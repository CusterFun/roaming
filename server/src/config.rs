//! 配置

use serde::Deserialize;

/// Web 配置
#[derive(Deserialize, Debug)]
pub struct WebConfig {
    /// web 服务监听地址
    pub addr: String,
    /// 安全 key
    pub secret_key: String,
}

///  MySQL 配置
#[derive(Deserialize, Debug)]
pub struct MySQLConfig {
    /// MySQL 地址
    pub path: String,
    /// MySQL 端口
    pub port: String,
    pub config: String,
    /// MySQL 数据库名
    pub dbname: String,
    /// MySQL 用户名
    pub username: String,
    /// MySQL 密码
    pub password: String,
}

impl MySQLConfig {
    pub fn dsn(self) -> String {
        format!(
            "mysql://{}:{}@{}:{}/{}",
            self.username, self.password, self.path, self.port, self.dbname
        )
    }
}

/// 配置
#[derive(Deserialize, Debug)]
pub struct Config {
    /// Web 配置
    pub web: WebConfig,
    pub mysql: MySQLConfig,
}

impl Config {
    /// 从环境变量中初始化配置
    pub fn from_env() -> Result<Self, config::ConfigError> {
        let mut cfg = config::Config::new();
        cfg.merge(config::Environment::new())?;
        cfg.try_into()
    }
}
