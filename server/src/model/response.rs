#![allow(dead_code)]

use axum::{
    body,
    response::{IntoResponse, Response},
};
use http::{header, HeaderValue, StatusCode};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Debug)]
pub struct ApiResp<T: Serialize> {
    pub code: u16,
    pub data: T,
    pub msg: String,
}

/// Err-服务错误返回, Privilege-权限限制, Auth-需要认证
#[derive(Deserialize, Serialize, Debug)]
pub enum ResponseCode {
    Success = 0,
    Error = 7,
    Privilege = 8,
    Auth = 9,
}

impl<T: Serialize + Default> IntoResponse for ApiResp<T> {
    fn into_response(self) -> Response {
        let body = match serde_json::to_vec(&self) {
            Ok(res) => res,
            Err(err) => {
                return Response::builder()
                    .status(StatusCode::INTERNAL_SERVER_ERROR)
                    .body(body::boxed(body::Full::from(err.to_string())))
                    .unwrap();
            }
        };

        let mut res = Response::new(body::boxed(body::Full::from(body)));
        res.headers_mut().insert(
            header::CONTENT_TYPE,
            HeaderValue::from_static("application/json"),
        );
        res
    }
}

impl<T: Serialize + Default> ApiResp<T> {
    pub fn new(code: u16, data: T, msg: String) -> ApiResp<T> {
        ApiResp { code, data, msg }
    }
    pub fn ok() -> ApiResp<T> {
        ApiResp::new(ResponseCode::Success as u16, T::default(), "操作成功".to_string())
    }
    pub fn ok_with_msg(msg: String) -> ApiResp<T> {
        ApiResp::new(ResponseCode::Success as u16, T::default(), msg)
    }
    pub fn ok_with_data(data: T) -> ApiResp<T> {
        ApiResp::new(ResponseCode::Success as u16,  data, "操作成功".to_string())
    }
    pub fn ok_with_detailed(data: T, msg: String) -> ApiResp<T> {
        ApiResp::new(ResponseCode::Success as u16, data, msg)
    }
    pub fn fail() -> ApiResp<T> {
        ApiResp::new(ResponseCode::Error as u16, T::default(), "操作失败".to_string())
    }
    pub fn fail_with_msg(msg: String) -> ApiResp<T> {
        ApiResp::new(ResponseCode::Error as u16, T::default(), msg)
    }
    pub fn fail_with_detailed(data: T, msg: String) -> ApiResp<T> {
        ApiResp::new(ResponseCode::Error as u16, data, msg)
    }
}
