use std::time::Duration;

use sqlx::{mysql::MySqlPoolOptions, MySqlPool};

/// 获取数据库连接池
pub async fn connect(cfg: &crate::Config) -> Result<MySqlPool, crate::AppError> {
    MySqlPoolOptions::new()
        .max_connections(cfg.db.min_connections)
        .min_connections(cfg.db.max_connections)
        .max_lifetime(Duration::from_secs(30 * 60)) // 30 mins
        .idle_timeout(Duration::from_millis(600000))
        .connect(&cfg.db.database_url)
        .await
        .map_err(|err| {
            tracing::error!("数据库链接失败! {}", err);
            err.into()
        })
}

/// 迁移数据库表
pub async fn migrate(db: &MySqlPool) -> Result<(), crate::AppError> {
    match sqlx::migrate!("db/migrations").run(db).await {
        Ok(_) => Ok(()),
        Err(err) => {
            tracing::error!("db::migrate: 数据库迁移失败! {}", err);
            Err(err)
        }
    }?;
    Ok(())
}
