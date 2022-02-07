use std::{sync::Arc, collections::HashMap};

use axum::{
    extract::{Extension, Query},
    Json,
};
use serde::{Deserialize, Serialize};
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

#[derive(Deserialize, Serialize, Debug)]
pub struct AutoCodeStruct {
    pub struct_name: String,               // Struct 名称
    pub table_name: String,                // 表名称
    pub package_name: String,              // 文件名称
    pub home_package_name: Option<String>, // go 文件名称
    pub abbreviation: String,              // Strut 简称
    pub auto_create_api_to_sql: bool,      // 是否自动创建 api
    pub auto_move_file: bool,              // 是否自动移动文件
    pub fields: Vec<AutoCodeField>,
    pub dict_types: Option<Vec<String>>,
}

#[derive(Deserialize, Serialize, Debug)]
pub struct AutoCodeField {
    pub field_name: String,        // 字段名称
    pub field_desc: String,        // 中文名
    pub field_type: String,        // 字段数据类型
    pub field_json: String,        // 字段 json 名称
    pub data_type_long: String,    // 数据库字段长度
    pub comment: String,           // 数据库字段描述
    pub column_name: String,       // 数据库字段
    pub field_search_type: String, // 搜索条件
    pub dict_type: String,         // 字典
}

pub async fn preview_temp(
    Extension(state): Extension<Arc<AppState>>,
    Json(req): Json<AutoCodeStruct>,
) -> Json<Value> {
    let auto_code = sys_auto_code::preview_temp(&state.pool, req).await;
    let res = ApiResp::<HashMap<String, String>>::ok_with_data(auto_code.ok().unwrap());
    Json(json!(res))
}
