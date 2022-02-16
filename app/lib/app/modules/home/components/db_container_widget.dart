import 'package:app/app/modules/home/controllers/sql_to_code_controller.dart';
import 'package:get/get.dart';

import '../components/define_name_widget.dart';
import '../components/field_info_widget.dart';
import '../components/select_db_widget.dart';
import 'package:flutter/material.dart';

class DbContainerWidget extends StatefulWidget {
  const DbContainerWidget({Key? key}) : super(key: key);

  @override
  _DbContainerWidgetState createState() => _DbContainerWidgetState();
}

class _DbContainerWidgetState extends State<DbContainerWidget> {
  SqlToCodeController c = Get.put(SqlToCodeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectDbWidget(),
          DefineNameWidget(),
          FieldInfoWidget(),
        ],
      ),
    );
  }
}
