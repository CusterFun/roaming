import 'package:app/flutter_flow/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class FieldInfoWidget extends GetView<SqlToCodeController> {
  @override
  Widget build(BuildContext context) {
    List<DataRow> dateRows = [];
    var data = controller.columnList.value.data;
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        dateRows.add(
          DataRow(
            cells: [
              DataCell(Text('${data[i].columnName}')),
              DataCell(Text('${data[i].columnComment}')),
              DataCell(Text('${data[i].columnName}')),
              DataCell(Text('${data[i].dataType}')),
              DataCell(Text('${data[i].columnName}')),
              DataCell(Text('${data[i].columnComment}')),
              DataCell(
                Row(
                  children: [
                    TextButton(onPressed: null, child: Text('编辑')),
                    TextButton(onPressed: null, child: Text('删除')),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FFButtonWidget(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('预览代码'),
                    content: controller.tableName.value != ''
                        ? Column(
                            children: [
                              Text(controller.structName.value),
                              Text(controller.abbreviation.value),
                              Text(controller.description.value),
                              Text(controller.packageName.value),
                              Text(controller.autoCreateApiToSql.value
                                  ? 'true'
                                  : 'false'),
                              Text(controller.autoMoveFile.value
                                  ? 'true'
                                  : 'false'),
                              Text('表名: ${controller.tableName.value}'),
                            ],
                          )
                        : Container(),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('确定'),
                      ),
                    ],
                  );
                },
              );
            },
            text: '预览代码',
            options: FFButtonOptions(
              width: 150,
              height: 50,
              color: Colors.white,
              textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF262D34),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
              elevation: 1,
              borderSide: BorderSide(
                color: Color(0xFFDBE2E7),
                width: 1,
              ),
              borderRadius: 40,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Field名')),
                  DataColumn(label: Text('中文名')),
                  DataColumn(label: Text('FieldJson')),
                  DataColumn(label: Text('Field数据类型')),
                  DataColumn(label: Text('数据库字段')),
                  DataColumn(label: Text('数据库字段描述')),
                  DataColumn(label: Text('操作')),
                ],
                rows: dateRows,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
