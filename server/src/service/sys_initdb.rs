use crate::model::sys_initdb::InitDB;
use mysql::prelude::*;
use mysql::*;

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

    // 建立数据库连接池
}
