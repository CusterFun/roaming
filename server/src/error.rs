use axum::{http::StatusCode, Json};
use serde_json::{json, Value};
use thiserror::Error;

/// 使用 thiserror 的派生宏来自定义 AppError 错误类型
#[derive(Debug, Error)]
pub enum AppError {
    #[error(transparent)]
    SqlxError(#[from] sqlx::Error),
}

pub type ApiError = (StatusCode, Json<Value>); // Api 格式的错误
pub type ApiResult<T> = std::result::Result<T, ApiError>; // Api 格式的 Result
pub type AppResult<T> = std::result::Result<T, AppError>; // App 内部的 Result

impl From<AppError> for ApiError {
    fn from(err: AppError) -> Self {
        let status = StatusCode::INTERNAL_SERVER_ERROR;
        let payload = json!({"code": 7, "msg": err.to_string()});
        (status, Json(payload))
    }
}
