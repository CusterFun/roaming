use axum::{http::StatusCode, Json};
use serde_json::{json, Value};
use thiserror::Error;

/// 使用 thiserror 的派生宏来自定义 WebError 错误类型
#[derive(Debug, Error)]
pub enum WebError {}

pub type ApiError = (StatusCode, Json<Value>);
pub type ApiResult<T> = std::result::Result<T, ApiError>;

impl From<WebError> for ApiError {
    fn from(err: WebError) -> Self {
        let status = StatusCode::INTERNAL_SERVER_ERROR;
        let payload = json!({"code": 7, "msg": err.to_string()});
        (status, Json(payload))
    }
}
