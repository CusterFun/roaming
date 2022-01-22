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

    let mysql_config = conf.database_url();
    let database_url = format!("\nDATABASE_URL={}\n", mysql_config);

    write_mysql_config(database_url);
}

/// 写入配置文件
fn write_mysql_config(database_url: String) {
    use std::fs::OpenOptions;
    use std::io::Write;
    let mut file = OpenOptions::new()
        .append(true)
        .open("./.env")
        .expect("打开.env文件失败");
    file.write_all(database_url.as_bytes())
        .expect("写入.env文件失败");
    tracing::info!("DATABASE_URL 写入 .env 文件成功, 请重启服务器！");
}
