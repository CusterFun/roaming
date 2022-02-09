mod config;
mod db;
mod error;
mod route;
mod state;

use std::sync::Arc;

pub use crate::config::Config;
pub use error::AppError;
pub use state::AppState;

#[tokio::main]
async fn main() {
    // Set the RUST_LOG, if it hasn't been explicitly defined
    if std::env::var_os("RUST_LOG").is_none() {
        std::env::set_var("RUST_LOG", "debug");
    }
    tracing_subscriber::fmt::init();

    // 加载配置文件
    let cfg = Config::from_env().unwrap();

    // 连接数据库
    let db_pool = db::connect(&cfg).await.unwrap();
    // db::migrate(&db_pool).await.unwrap();

    let state = Arc::new(AppState { pool: db_pool });
    let routes = route::routes(state);

    let addr = std::net::SocketAddr::from((cfg.server.host, cfg.server.port));
    tracing::info!("Web 服务监听于: {}", addr);

    axum::Server::bind(&addr)
        .serve(routes.into_make_service())
        .await
        .expect("Web 服务启动失败");
}
