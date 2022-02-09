use axum::{http::StatusCode, Json};
use serde_json::{json, Value};
use thiserror::Error;

/// 使用 thiserror 的派生宏来自定义 AppError 错误类型
#[derive(Debug, Error)]
pub enum AppError {
    #[error(transparent)]
    SqlxError(#[from] sqlx::Error),
    #[error("Internal error")]
    Internal(String),
    #[error(transparent)]
    ValidationError(#[from] validator::ValidationErrors),
}

/// Api 格式的错误
pub type ApiError = (StatusCode, Json<Value>);
/// Api 格式的 Result
pub type ApiResult<T> = std::result::Result<T, ApiError>;
/// App 内部的 Result
pub type AppResult<T> = std::result::Result<T, AppError>;

impl From<AppError> for ApiError {
    fn from(err: AppError) -> Self {
        let status = match err {
            AppError::ValidationError(_) => StatusCode::BAD_REQUEST,
            _ => StatusCode::INTERNAL_SERVER_ERROR,
        };
        let payload = json!({"code": 7, "msg": err.to_string()});
        (status, Json(payload))
    }
}

impl From<sqlx::migrate::MigrateError> for AppError {
    fn from(err: sqlx::migrate::MigrateError) -> Self {
        AppError::Internal(err.to_string())
    }
}
