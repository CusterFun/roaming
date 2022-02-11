[陈天老师的BiliBili视频](https://www.bilibili.com/video/BV1Q34y1y7DJ) 

介绍 web 框架 axum，使用 axum 做一套带认证的，包括 REST API 和静态资源在内的 web 服务器。

```rust
use std::net::SocketAddr;

use axum::{
    response::Html,
    routing::{get, post},
    Json, Router, Server, http::StatusCode,
};
use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Todo {
    pub id: usize,
    pub title: String,
    pub completed: bool,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateTodo {
    pub title: String,
}

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(index_handler))
        .route("/todos", get(todos_handler).post(create_todo_handler));
    let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    println!("Listening on http://{}", addr);

    Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

async fn index_handler() -> Html<&'static str> {
    Html("Hello, world!")
}

async fn todos_handler() -> Json<Vec<Todo>> {
    Json(vec![
        Todo {
            id: 1,
            title: "Todo 1".into(),
            completed: false,
        },
        Todo {
            id: 2,
            title: "Todo 2".into(),
            completed: false,
        },
    ])
}


async fn create_todo_handler(Json(_todo): Json<CreateTodo>) -> StatusCode {
    StatusCode::CREATED
}
```

```shell
cargo run --example basic
```

```shell
http "http://localhost:8080"
http "http://localhost:8080/todos"
http post "http://localhost:8080/todos" title=hello
```

