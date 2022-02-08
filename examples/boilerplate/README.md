# Project Boilerplate 项目模板

基于学习使用的项目模板

## 技术栈

- axum
- sqlx

## 参考项目

- [AXUM中文网 - 带你使用 axum 构建企业应用 - axum.rs](https://axum.rs/)
- [svenstaro/rust-web-boilerplate: Rust web template for modern web backend applications (github.com)](https://github.com/svenstaro/rust-web-boilerplate)
- [Z4RX/axum_jwt_example (github.com)](https://github.com/Z4RX/axum_jwt_example)
- [Whatsoo/whatsoo: A opensource community written by rust (github.com)](https://github.com/Whatsoo/whatsoo)

## Let's Code

### 1. 工程的创建

```shell
cargo new server
```

在 `Cargo.toml` 文件中，填入以下内容：

```toml
[package]
edition = "2021"
name = "server"
version = "0.1.0"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
# axum
async-trait = "0.1"
axum = "0.4"
futures = "0.3"
headers = "0.3"
http = "0.2"
http-body = "0.4"
tokio = {version = "1", features = ["full"]}
tower = {version = "0.4", features = ["full"]}
tower-http = {version = "0.2", features = ["add-extension", "compression-br", "trace"]}
tracing = "0.1"
tracing-subscriber = "0.3"

# bytes
bytes = "1"

# jsonwebtoken
jsonwebtoken = "8"

# json
serde = "1"
serde_derive = "1"
serde_json = "1"

# sqlx
sqlx = {version = "0.5", features = ["runtime-tokio-native-tls", "uuid", "json", "macros", "migrate", "mysql", "chrono", "time"]}

# uuid
uuid = {version = "0.8", features = ["serde", "v4"]}

# chrono
chrono = {version = "0.4", features = ["serde"]}

# other
anyhow = "1"
config = "0.11"
dotenv = "0.15"
lazy_static = "1"
tera = "1"
thiserror = "1"
```

工具类 crate 安装：

- cargo-edit，包含 `cargo add`、`cargo rm`，以及 `cargo upgrade`，可以让我们方便地管理 crate。
- cargo-watch，监视项目的源代码，以了解其更改，并在源代码发生更改时，运行 Cargo 命令。

```shell
cargo install cargo-edit
cargo install cargo-watch
```

> 安装依赖较多，如果时间较长，请[配置 Rust 工具链的国内源](https://rsproxy.cn)。

### 2. Error

当开始一个新的Rust项目时，做的第一件事就是创建项目的错误枚举。

我并不试图去猜测所有的错误变体，而是让它们自然地增长。

也就是说，我总是创建一个Internal(String)变体来处理我不希望或无法优雅地处理的错误。

```rust
use std::io;

use axum::{http::StatusCode, Json};
use serde_json::{json, Value};
use thiserror::Error;

/// 使用 thiserror 的派生宏来自定义 AppError 错误类型
#[derive(Debug, Error)]
pub enum AppError {
    #[error(transparent)]
    SqlxError(#[from] sqlx::Error),
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error("Internal error")]
	Internal(String),
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

```









## 学习链接

- [GraphQL] 构建 Rust 异步 GraphQL 服务：基于 tide + async-graphql + mongodb
  - [（1）- 起步及 crate 选择](https://blog.budshome.com/budshome/gou-jian-rust-yi-bu-graphql-fu-wu-:ji-yu-tide-+-async-graphql-+-mongodb(1)--qi-bu-ji-crate-xuan-ze)
  - [（2）- 查询服务](https://blog.budshome.com/budshome/gou-jian-rust-yi-bu-graphql-fu-wu-:ji-yu-tide-+-async-graphql-+-mongodb(2)--cha-xun-fu-wu)
  - [（3）- 重构](https://blog.budshome.com/budshome/gou-jian-rust-yi-bu-graphql-fu-wu-:ji-yu-tide-+-async-graphql-+-mongodb(3)--zhong-gou)
- [优雅地组合：谈谈 axum -  陈小天 · 程序人生](https://mp.weixin.qq.com/s/mrZfqYIBKBCOXiiCj3wdHg)

