//! 配置

use std::path::Path;

use serde::Deserialize;

/// web 配置
#[derive(Deserialize, Debug)]
pub struct WebConfig {
    /// web 服务监听地址
    pub addr: String,
    /// 安全 key
    pub secret_key: String,
}

/// 配置
#[derive(Deserialize, Debug)]
pub struct Config {
    /// web 配置
    pub web: WebConfig,
}

impl Config {
    /// 从环境变量中初始化配置
    pub fn from_env() -> Result<Self, config::ConfigError> {
        let mut cfg = config::Config::new();
        cfg.merge(config::File::from(Path::new("env.json")))?;
        cfg.try_into()
    }
}
