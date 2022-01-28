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

pub async fn get_tables(pool: &MySqlPool, db_name: &str) -> AppResult<Vec<Table>> {
    let recs = sqlx::query!(
        r#"
        SELECT table_name 
        FROM INFORMATION_SCHEMA.TABLES 
        WHERE table_schema = ?
        "#,
        db_name
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

#[derive(FromRow, Serialize)]
pub struct Column {
    pub data_type: String,
    pub column_name: String,
    pub column_comment: String,
}

pub async fn get_column(
    pool: &MySqlPool,
    db_name: &str,
    table_name: &str,
) -> AppResult<Vec<Column>> {
    let recs = sqlx::query!(
        r#"
    SELECT COLUMN_NAME    column_name,
       DATA_TYPE          data_type,
       CASE DATA_TYPE
           WHEN 'longtext' THEN c.CHARACTER_MAXIMUM_LENGTH
           WHEN 'varchar' THEN c.CHARACTER_MAXIMUM_LENGTH
           WHEN 'double' THEN CONCAT_WS(',', c.NUMERIC_PRECISION, c.NUMERIC_SCALE)
           WHEN 'decimal' THEN CONCAT_WS(',', c.NUMERIC_PRECISION, c.NUMERIC_SCALE)
           WHEN 'int' THEN c.NUMERIC_PRECISION
           WHEN 'bigint' THEN c.NUMERIC_PRECISION
           ELSE '' END AS data_type_long,
       COLUMN_COMMENT     column_comment
	FROM INFORMATION_SCHEMA.COLUMNS c
	WHERE table_name = ?
    AND table_schema = ?
        "#,
        table_name,
        db_name
    )
    .fetch_all(pool)
    .await?;
    for rec in &recs {
        println!("{:?}", rec);
    }
    Ok(recs
        .into_iter()
        .map(|rec| Column {
            data_type: rec.data_type.unwrap_or_default(),
            column_name: rec.column_name.unwrap_or_default(),
            column_comment: rec.column_comment,
        })
        .collect())
}
