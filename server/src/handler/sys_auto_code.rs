use std::sync::Arc;

use axum::{extract::Extension, Json};
use serde_json::{json, Value};

use crate::{error::ApiResult, model::AppState};

pub async fn get_db(Extension(state): Extension<Arc<AppState>>) -> ApiResult<Json<Value>> {
    
    Ok(Json(json!({ "status": "ok" })))
}
