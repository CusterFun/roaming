use std::sync::Arc;

use axum::{extract::Extension, Json};
use serde_json::{json, Value};

use crate::{
    error::ApiResult,
    model::{response::ApiResp, AppState},
    service::sys_auto_code,
};

pub async fn get_db(Extension(state): Extension<Arc<AppState>>) -> ApiResult<Json<Value>> {
    let db = sys_auto_code::get_db(&state.pool).await?;
    let res = ApiResp::<Vec<sys_auto_code::Db>>::ok_with_data(db);
    Ok(Json(json!(res)))
}

pub async fn get_tables(Extension(state): Extension<Arc<AppState>>) -> ApiResult<Json<Value>> {
    let tables = sys_auto_code::get_tables(&state.pool).await?;
    let res = ApiResp::<Vec<sys_auto_code::Table>>::ok_with_data(tables);
    Ok(Json(json!(res)))
}
