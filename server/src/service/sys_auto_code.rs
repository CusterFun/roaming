use std::{collections::HashMap, fs, io, path::Path};

use serde::{Deserialize, Serialize};
use sqlx::{FromRow, MySqlPool};
use tera::{Context, Tera};

use crate::{error::AppResult, handler::sys_auto_code::AutoCodeStruct};

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

const BASE_PATH: &str = "templates";
const BASE_PATH2: &str = "templates\\";

pub async fn preview_temp(
    _pool: &MySqlPool,
    auto_code: AutoCodeStruct,
) -> AppResult<HashMap<String, String>> {
    let templates = Tera::new("templates/**/*").expect("Tera 模板引擎初始化失败!");
    let mut ctx = Context::new();
    ctx.insert("auto_code", &auto_code);

    let mut ret = HashMap::new();
    let mut path_list: HashMap<String, String> = HashMap::new();

    // 获取文件夹下所有 .tera 文件
    let tpl_file_list =
        get_all_tpl_file(BASE_PATH, &mut vec![], &mut path_list).unwrap_or_default();
    tracing::info!("tpl_file_list: {:?}", tpl_file_list);
    tracing::info!("path_list: {:?}", path_list);

    // TODO:
    // 2. 新建文件夹以及迁移文件
    // 3. 使用用户新建的模板文件
    // 4. 使用云仓库中开源的模板文件
    for tpl in tpl_file_list {
        let path = path_list.get(&tpl);
        if let Some(value) = path {
            dbg!(value);
            let temp = value.split('\\').collect::<Vec<&str>>().join("/");
            dbg!(&temp);
            let mut render = templates.render(&temp, &ctx).expect("渲染模板文件失败");
            // .map_err(|e| return AppError::Internal(format!("渲染模板文件失败: {}", e)))?;
            let mut language: String = "txt".to_owned();
            let split: Vec<&str> = tpl.split('.').collect();
            if split.len() > 2 && split.contains(&"tera") {
                language = split[1].trim().to_string();
            }
            render = format!("```{}\n\n{}\n\n\n```", language, render);
            ret.insert(tpl.strip_suffix(".tera").unwrap().to_string(), render);
        };
    }

    Ok(ret)
}

fn get_all_tpl_file(
    base_path: &str,
    file_list: &mut Vec<String>,
    path_list: &mut HashMap<String, String>,
) -> AppResult<Vec<String>> {
    let entries = fs::read_dir(base_path)?
        .map(|res| res.map(|e| e.path()))
        .collect::<Result<Vec<_>, io::Error>>()?;

    for file in entries.iter() {
        dbg!(file);
        let file_name = file
            .file_name()
            .unwrap_or_default()
            .to_str()
            .unwrap_or_default();

        if file.is_dir() {
            dbg!(Path::new(base_path)
                .join(file_name)
                .to_str()
                .unwrap_or_default());
            get_all_tpl_file(
                Path::new(base_path)
                    .join(file_name)
                    .to_str()
                    .unwrap_or_default(),
                // &(base_path.to_owned() + "/" + file_name),
                file_list,
                path_list,
            )?;
        } else if file_name.ends_with(".tera") {
            file_list.push(file_name.to_string());
            path_list.insert(
                file_name.to_string(),
                file.to_str()
                    .unwrap_or_default()
                    .to_string()
                    // .strip_prefix(format!("{}/", BASE_PATH).as_str())
                    .strip_prefix(BASE_PATH2)
                    .unwrap_or_default()
                    .to_string(),
            );
        }
    }
    Ok(file_list.to_vec())
}
