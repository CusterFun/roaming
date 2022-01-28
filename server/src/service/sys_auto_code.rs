use serde::{Deserialize, Serialize};
use sqlx::{FromRow, MySqlPool};

use crate::error::AppResult;

#[derive(Debug, Default, Serialize, Deserialize, FromRow)]
pub struct Db {
    pub database: String,
}

pub async fn get_db(pool: &MySqlPool) -> AppResult<Vec<Db>> {
    let recs =
        sqlx::query!(r#"SELECT SCHEMA_NAME AS `database` FROM INFORMATION_SCHEMA.SCHEMATA;"#)
            .fetch_all(pool)
            .await?;
    for rec in &recs {
        println!("{:?}", rec);
    }
    Ok(recs
        .into_iter()
        .map(|rec| Db {
            database: rec.database.unwrap_or_default(),
        })
        .collect())
}

#[derive(FromRow, Serialize)]
pub struct Table {
    pub table_name: String,
}

pub async fn get_tables(pool: &MySqlPool) -> AppResult<Vec<Table>> {
    let database_url = std::env::var("DATABASE_URL").unwrap();
    let dbname = database_url.split('/').last().unwrap();
    dbg!(dbname);
    let recs = sqlx::query!(
        r#"
        SELECT table_name 
        FROM INFORMATION_SCHEMA.TABLES 
        WHERE table_schema = ?
        "#,
        dbname
    )
    .fetch_all(pool)
    .await?;

    for rec in &recs {
        println!("{:?}", rec);
    }
    Ok(recs
        .into_iter()
        .map(|rec| Table {
            table_name: rec.TABLE_NAME.unwrap_or_default(),
        })
        .collect())
}
