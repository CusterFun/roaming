use axum::{routing::get, Router};

pub mod sys_initdb;

pub fn routers() -> Router {
    Router::new().route("/", get(sys_initdb::str_response))
}
