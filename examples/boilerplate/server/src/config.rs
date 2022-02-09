use std::net::IpAddr;

use serde::Deserialize;

/// 配置
#[derive(Deserialize, Debug)]
pub struct Config {
    pub db: DBConifg,
    pub server: ServerConfig,
}

/// 数据库配置
#[derive(Deserialize, Debug)]
pub struct DBConifg {
    /// 数据库配置
    pub database_url: String,
    /// 数据库最大链接
    pub max_connections: u32,
    /// 数据库最少链接
    pub min_connections: u32,
}

/// 服务端配置
#[derive(Deserialize, Debug)]
pub struct ServerConfig {
    /// web 服务监听地址
    pub host: IpAddr,
    /// web 服务监听端口
    pub port: u16,
    /// 安全密钥
    pub secret_key: String,
}

impl Config {
    /// 从环境变量中初始化配置
    pub fn from_env() -> Result<Self, config::ConfigError> {
        dotenv::dotenv().ok();

        let mut cfg = config::Config::new();
        cfg.merge(config::Environment::new())?;
        cfg.try_into()
    }
}
