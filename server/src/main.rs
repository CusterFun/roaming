use axum::Router;

use server::config;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let cfg = config::Config::from_env().unwrap();
    tracing::info!("Web 服务监听于: {}", &cfg.web.addr);

    let app = Router::new();

    axum::Server::bind(&cfg.web.addr.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
