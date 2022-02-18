import 'dart:convert';

import 'package:app/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/dbcolumn.dart';
import '../model/dbname.dart';
import '../model/dbtables.dart';

class SqlToCodeController extends GetxController {
  final count = 0.obs;
  final List<String> dbnames = []; // 数据库名的数组
  List<String> tables = []; // 表名的数组
  final getTableDisabled = true.obs; // 未选择数据库不能选择表
  final dbname = ''.obs; // 选择的数据库名
  final table = ''.obs; // 选择的表名
  final structName = ''.obs; // 使用此表创建时的表名
  var defineNameKey = GlobalKey<FormState>().obs;

  @override
  void onInit() {
    super.onInit();
    defineNameKey.value = GlobalKey<FormState>();
    getDB();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void changeDbname(value) => dbname.value = value;
  void changeTable(value) => table.value = value;

  /// 获取数据库名
  void getDB() async {
    dbname.value = '';
    try {
      var res = await Dio().get(Api.GET_DB);
      Get.snackbar('提示', res.data['msg']);
      if (res.data['code'] == 0) {
        var data = DBNameListMo.fromJson(res.data);
        for (var i = 0; i < data.data!.length; i++) {
          dbnames.add(data.data![i].database!);
        }
      }
    } catch (e) {
      Get.snackbar('提示', e.toString());
    }
  }

  /// 通过数据库名获取表名
  void getTables(String dbname) async {
    tables = [];
    table.value = '';
    try {
      var res = await Dio().get(Api.GET_TABLES, queryParameters: {
        'db_name': dbname,
      });
      Get.snackbar('提示', res.data['msg']);
      getTableDisabled.value = false;
      if (res.data['code'] == 0) {
        var data = TableNameMo.fromJson(res.data);
        for (var i = 0; i < data.data!.length; i++) {
          tables.add(data.data![i].tableName!);
        }
      }
    } catch (e) {
      Get.snackbar('提示', e.toString());
    }
  }

  final columnList = ColumnsMo().obs;

  /// 获取指定表所有字段信息
  void getColumns() async {
    structName.value = '';
    try {
      var res = await Dio().get(Api.GET_COLUMNS, queryParameters: {
        'db_name': dbname.value,
        'table_name': table.value,
      });
      Get.snackbar('提示', res.data['msg']);
      if (res.data['code'] == 0) {
        columnList.value = ColumnsMo.fromJson(res.data);
        structName.value = table.value;
        var data = ColumnsMo.fromJson(res.data);
        for (var i = 0; i < data.data!.length; i++) {
          print('column: ${data.data![i].toJson().toString()}');
        }
      }
    } catch (e) {
      Get.snackbar('提示', e.toString());
    }
  }

  ///
  var abbreviation = ''.obs;
  var tableName = ''.obs;
  var description = ''.obs;
  var packageName = ''.obs;
  var autoCreateApiToSql = false.obs;
  var autoMoveFile = false.obs;

  void changeTableName(val) => tableName.value = val;

  /// 预览模板代码
  Future<bool> preview() async {
    // 清空数据
    codeTabs.value = [];
    codeTmps.value = [];
    //读取当前 Form 状态
    var form = defineNameKey.value.currentState;
    form?.save();
    try {
      var res = await Dio().post(Api.GET_PREVIEW, data: {
        "struct_name": structName.value,
        "table_name": tableName.value,
        "package_name": packageName.value,
        "abbreviation": abbreviation.value,
        "description": description.value,
        "auto_create_api_to_sql": autoCreateApiToSql.value,
        "auto_move_file": autoMoveFile.value,
        "hump_package_name": packageName.value,
        "fields": [],
      });
      Get.snackbar('提示', res.data['msg']);
      if (res.data['code'] == 0) {
        (res.data['data'] as Map<String, dynamic>).forEach((key, value) {
          codeTabs.add(key);
          codeTmps.add(value);
        });
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// 预览代码
  final codeTabs = [].obs;
  final codeTmps = [].obs;
}
