use anyhow::Result;
use std::{sync::Arc, time::Duration};

use axum::{
    http::StatusCode,
    routing::{get_service, post},
    AddExtensionLayer, Router,
};
use sqlx::mysql::MySqlPoolOptions;

use tower_http::services::ServeDir;

use server::{
    config,
    handler::{self, sys_initdb},
    model,
};

pub const MAX_POOL_SIZE: u32 = 20;
pub const MIN_POOL_SIZE: u32 = 10;

#[tokio::main]
async fn main() -> Result<()> {
    tracing_subscriber::fmt::init();

    dotenv::dotenv().ok();
    let cfg = config::Config::from_env().unwrap();
    let state;
    let app;

    let static_serve = get_service(ServeDir::new("static")).handle_error(|err| async move {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("载入静态资源出错: {}", err),
        )
    });

    if std::env::var("DATABASE_URL").ok() != None {
        let database_url = std::env::var("DATABASE_URL").expect("数据库连接未设置");
        let max_pool_size: u32 = std::env::var("MAX_POOL_SIZE")
            .unwrap_or_else(|_| MAX_POOL_SIZE.to_string())
            .parse::<u32>()
            .unwrap_or(MAX_POOL_SIZE);
        let min_pool_size: u32 = std::env::var("MIN_POOL_SIZE")
            .unwrap_or_else(|_| MIN_POOL_SIZE.to_string())
            .parse::<u32>()
            .unwrap_or(MIN_POOL_SIZE);
        let mysql_pool: sqlx::MySqlPool = MySqlPoolOptions::new()
            .max_connections(max_pool_size)
            .min_connections(min_pool_size)
            .max_lifetime(Duration::from_millis(1800000))
            .idle_timeout(Duration::from_millis(600000))
            .connect(&database_url)
            .await?;

        tracing::info!("数据库连接创建成功");
        state = Arc::new(model::AppState { pool: mysql_pool });

        let api_router = handler::routers();

        app = Router::new()
            .nest("/", api_router)
            .nest("/static", static_serve)
            .layer(AddExtensionLayer::new(state));
    } else {
        tracing::error!(
            "创建数据库连接失败, 前往 {}/initdb 初始化数据库",
            &cfg.web.addr
        );
        app = Router::new()
            .route("/initdb", post(sys_initdb::initdb))
            .nest("/static", static_serve);
    }

    tracing::info!("Web 服务监听于: {}", &cfg.web.addr);

    axum::Server::bind(&cfg.web.addr.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .expect("Web 服务启动失败");

    Ok(())
}
