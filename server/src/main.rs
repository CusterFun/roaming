use std::sync::Arc;

use axum::{
    http::StatusCode,
    routing::{get_service, post},
    AddExtensionLayer, Router,
};
use tower_http::services::ServeDir;

use server::{
    config,
    handler::{self, sys_initdb},
    model,
};

#[tokio::main]
async fn main() {
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

    if let Ok(pool) = model::create_mysql_pool() {
        tracing::info!("数据库链接池创建成功");
        state = Arc::new(model::AppState { pool });

        let api_router = handler::routers();

        app = Router::new()
            .nest("/", api_router)
            .nest("/static", static_serve)
            .layer(AddExtensionLayer::new(state));
    } else {
        tracing::error!(
            "创建数据库连接池失败, 前往 {}/initdb 初始化数据库",
            &cfg.web.addr
        );
        app = Router::new()
            .route("/initdb", post(sys_initdb::initdb))
            .nest("/static", static_serve);
    };

    tracing::info!("Web 服务监听于: {}", &cfg.web.addr);

    axum::Server::bind(&cfg.web.addr.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .expect("Web 服务启动失败");
}
