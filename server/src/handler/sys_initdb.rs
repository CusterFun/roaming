use axum::Json;

use serde_json::{json, Value};

use crate::{error::ApiResult, model::sys_initdb::InitDB, service::sys_initdb};
use crate::model::response::ApiResp;

pub async fn str_response() -> &'static str {
    "Hello, axum.rs"
}

pub async fn initdb(Json(req): Json<InitDB>) -> ApiResult<Json<Value>> {
    sys_initdb::initdb(req.clone())?;
    let res:ApiResp<InitDB> = ApiResp::ok_with_detailed(req,"initdb success".to_string());
    Ok(Json(json!(res)))
}
