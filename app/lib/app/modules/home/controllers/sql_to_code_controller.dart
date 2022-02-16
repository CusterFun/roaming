import 'package:app/api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/dbcolumn.dart';
import '../model/dbname.dart';
import '../model/dbtables.dart';

class SqlToCodeController extends GetxController {
  final count = 0.obs;
  final List<String> dbnames = [];
  List<String> tables = [];
  final getTableDisabled = true.obs;
  final dbname = ''.obs;
  final table = ''.obs;

  @override
  void onInit() {
    super.onInit();

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

  /// 获取指定表所有字段信息
  void getColumns() async {
    if (dbname.value == '' || table.value == '') {
      Get.snackbar('提示', '请选择数据库和表名');
      return;
    }
    try {
      var res = await Dio().get(Api.GET_COLUMNS, queryParameters: {
        'db_name': dbname.value,
        'table_name': table.value,
      });
      Get.snackbar('提示', res.data['msg']);
      if (res.data['code'] == 0) {
        var data = ColumnsMo.fromJson(res.data);
        for (var i = 0; i < data.data!.length; i++) {
          print('column: ${data.data![i].toJson().toString()}');
        }
      }
    } catch (e) {
      Get.snackbar('提示', e.toString());
    }
  }
}
