use std::sync::Arc;

use axum::{
    extract::{Extension, Query},
    Json,
};
use serde::Deserialize;
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

#[derive(Deserialize)]
pub struct GetTablesQuery {
    pub db_name: Option<String>,
}

pub async fn get_tables(
    Extension(state): Extension<Arc<AppState>>,
    Query(args): Query<GetTablesQuery>,
) -> ApiResult<Json<Value>> {
    let db_name = args.db_name.unwrap_or_else(|| "".to_string());
    let tables = sys_auto_code::get_tables(&state.pool, &db_name).await?;
    let res = ApiResp::<Vec<sys_auto_code::Table>>::ok_with_data(tables);
    Ok(Json(json!(res)))
}

#[derive(Deserialize)]
pub struct GetColumnQuery {
    pub db_name: Option<String>,
    pub table_name: String,
}

pub async fn get_column(
    Extension(state): Extension<Arc<AppState>>,
    Query(args): Query<GetColumnQuery>,
) -> ApiResult<Json<Value>> {
    let db_name = args.db_name.unwrap_or_else(|| "".to_string());
    let tables = sys_auto_code::get_column(&state.pool, &db_name, &args.table_name).await?;
    let res = ApiResp::<Vec<sys_auto_code::Column>>::ok_with_data(tables);
    Ok(Json(json!(res)))
}
