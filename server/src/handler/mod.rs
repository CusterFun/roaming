use axum::{
    routing::{get, post},
    Router,
};

pub mod sys_auto_code;
pub mod sys_initdb;

pub fn routers() -> Router {
    Router::new()
        .route("/", get(sys_initdb::str_response))
        .route("/initdb", post(sys_initdb::initdb))
        .route("/autoCode/getDB", get(sys_auto_code::get_db)) // 获取数据库
        .route("/autoCode/getTables", get(sys_auto_code::get_tables)) // 获取对应数据库的表
        .route("/autoCode/getColumn", get(sys_auto_code::get_column)) // 获取指定表所有字段信息
        .route("/autoCode/preview", post(sys_auto_code::preview_temp)) // 获取自动创建代码预览
}
