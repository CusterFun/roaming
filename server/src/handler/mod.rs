use axum::{routing::get, Router};

pub mod sys_initdb;
pub mod sys_auto_code;

pub fn routers() -> Router {
    Router::new().route("/", get(sys_initdb::str_response))
}
