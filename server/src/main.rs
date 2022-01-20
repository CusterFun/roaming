use axum::{http::StatusCode, routing::get_service, Router};
use tower_http::services::ServeDir;

use server::{config, handler};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    dotenv::dotenv().ok();
    let cfg = config::Config::from_env().unwrap();
    tracing::info!("Web 服务监听于: {}", &cfg.web.addr);

    let static_serve = get_service(ServeDir::new("static")).handle_error(|err| async move {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("载入静态资源出错: {}", err),
        )
    });

    let api_router = handler::routers();
    let app = Router::new()
        .nest("/", api_router)
        .nest("/static", static_serve);

    axum::Server::bind(&cfg.web.addr.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .expect("Web 服务启动失败");
}
