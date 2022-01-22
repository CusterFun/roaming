use sqlx::MySqlPool;
pub mod sys_initdb;

pub struct AppState {
    pub pool: MySqlPool,
}

