## 源自

[Clean and Scalable Architecture for Web Applications in Rust (kerkour.com)](https://kerkour.com/rust-web-application-clean-architecture/)

book [Black Hat Rust](https://kerkour.com/black-hat-rust)  14.4.3 Architecting a Rust web application

![The CLean Architecture - source](https://kerkour.com/2022/web-application-architecture/ch10_clean_architecture.jpg)

[14.7 Let’s code(github)](https://github.com/skerkour/black-hat-rust/tree/main/ch_10/server)

## Let's code

### 1. 新建项目

```shell	
cargo new server
```

### 2. error

当开始一个新的Rust项目时，做的第一件事就是创建项目的错误枚举。

我并不试图去猜测所有的错误变体，而是让它们有机地增长。

也就是说，我总是创建一个Internal(String)变体来处理我不希望或无法优雅地处理的错误。

