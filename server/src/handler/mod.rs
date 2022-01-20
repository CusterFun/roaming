use axum::{
    routing::{get, post},
    Router,
};

pub mod sys_initdb;

pub fn routers() -> Router {
    Router::new()
        .route("/", get(sys_initdb::str_response))
        .route("/initdb", post(sys_initdb::initdb))
}
