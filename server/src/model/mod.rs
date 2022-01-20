use diesel::MysqlConnection;
use diesel::r2d2::ConnectionManager;

pub mod sys_initdb;

pub type Pool = r2d2::Pool<ConnectionManager<MysqlConnection>>;

pub struct AppState {
    pub pool: Pool,
}