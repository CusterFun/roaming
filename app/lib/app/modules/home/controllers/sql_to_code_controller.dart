import 'package:app/api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/dbname.dart';

class SqlToCodeController extends GetxController {
  final count = 0.obs;
  final List<String> dbnames = [];
  final getTableDisabled = true.obs;
  @override
  void onInit() {
    super.onInit();

    getDB();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  // 获取数据库名
  void getDB() async {
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

  void getTables() async {
    getTableDisabled.value = false;
  }
}
