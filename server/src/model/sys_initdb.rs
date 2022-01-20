use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
pub struct InitDB {
    pub dbtype: String,   // 数据库类型
    pub host: String,     // 服务器地址
    pub port: String,     // 数据库连接端口
    pub username: String, // 数据库用户名
    pub password: String, // 数据库密码
    pub db_name: String,  // 数据库名
}

impl InitDB {
    /// msyql 空数据库 建库链接
    pub fn mysql_empty_dsn(&mut self) -> String {
        if self.host.is_empty() {
            self.host = "127.0.0.1".to_string();
        }
        if self.port.is_empty() {
            self.port = "3306".to_string();
        }
        format!(
            "mysql://{}:{}@{}:{}",
            self.username, self.password, self.host, self.port
        )
    }
}
