use anyhow::Result;
use diesel::r2d2::ConnectionManager;
use diesel::MysqlConnection;

pub mod sys_initdb;

pub type Pool = r2d2::Pool<ConnectionManager<MysqlConnection>>;

pub struct AppState {
    pub pool: Pool,
}

/// 建立数据库连接池
pub fn create_mysql_pool() -> Result<Pool> {
    let database_url = std::env::var("DATABASE_URL")?;
    let manager = ConnectionManager::<MysqlConnection>::new(database_url);
    Ok(r2d2::Pool::builder()
        .build(manager)
        .expect("创建连接池失败"))
}
