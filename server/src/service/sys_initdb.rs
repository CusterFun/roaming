use diesel::MysqlConnection;
use diesel::r2d2::ConnectionManager;
use crate::model::sys_initdb::InitDB;
use mysql::prelude::*;
use mysql::*;
use crate::model;

pub fn initdb(conf: InitDB) {
    if conf.dbtype.to_lowercase() == "mysql" {
        init_mysql(conf);
    }
}

/// 初始化 mysql 数据库
fn init_mysql(mut conf: InitDB) {
    let dsn = conf.mysql_empty_dsn();

    // 创建数据库
    let opts = Opts::from_url(&dsn).unwrap();
    let mut conn = mysql::Conn::new(opts).unwrap();
    if conn
        .query::<mysql::Row, _>(format!("USE {}", conf.db_name))
        .is_err()
    {
        conn.query::<mysql::Row, _>(format!(
            "CREATE DATABASE {} DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;",
            conf.db_name
        ))
        .unwrap();
    }

    let mysql_config = conf.to_mysql_config();

    // 建立数据库连接池
    let _pool = get_mysql_pool(mysql_config.dsn());
}

fn get_mysql_pool(database_url: String) -> model::Pool {
    let manager = ConnectionManager::<MysqlConnection>::new(database_url);
    r2d2::Pool::builder().build(manager).expect("创建连接池失败")
}
