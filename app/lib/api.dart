// ignore_for_file: constant_identifier_names

class Api {
  static const BASE_URL = 'http://127.0.0.1:9527/';
  static const INIT_DB = BASE_URL + 'initdb'; // 初始化数据库连接
  static const GET_DB = BASE_URL + 'autoCode/getDB'; // 获取数据库名
  static const GET_TABLES = BASE_URL + 'autoCode/getTables'; // 获取对应数据库的表
  static const GET_COLUMNS = BASE_URL + 'autoCode/getColumn'; // 获取指定表所有字段信息
}
