use sqlx::MySqlPool;
pub mod sys_initdb;
pub mod response;

pub struct AppState {
    pub pool: MySqlPool,
}

