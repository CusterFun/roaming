use std::sync::Arc;

use axum::{
    handler::Handler,
    http::{StatusCode, Uri},
    response::IntoResponse,
    routing::{get, get_service},
    AddExtensionLayer, Router,
};
use tower_http::services::ServeDir;

pub fn routes(state: Arc<crate::AppState>) -> Router {
    let static_serve = get_service(ServeDir::new("static")).handle_error(|err| async move {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("载入静态资源出错: {}", err),
        )
    });

    Router::new()
        .route("/", get(|| async { "Welcome to use axum" }))
        .nest("/static", static_serve)
        .layer(AddExtensionLayer::new(state))
        .layer(tower_http::trace::TraceLayer::new_for_http())
        .fallback(fallback.into_service())
}

async fn fallback(uri: Uri) -> impl IntoResponse {
    (StatusCode::NOT_FOUND, format!("No route for {}", uri))
}
