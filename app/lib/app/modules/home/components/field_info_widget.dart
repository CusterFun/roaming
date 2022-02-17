import 'package:app/flutter_flow/index.dart';
import 'package:app/utils/string_fun.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class FieldInfoWidget extends GetView<SqlToCodeController> {
  @override
  Widget build(BuildContext context) {
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '序列',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  'Field名',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '中文名',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  'FieldJson',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  'Field数据类型',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '数据字段长度',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '数据库字段',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '数据库字段描述',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '搜索条件',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  '操作',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: controller.columnList.value.data != null && controller.columnList.value.data!.isNotEmpty
                ? Column(
                    children: [
                      for (var item in controller.columnList.value.data!) ...[
                        columnInfo(context, item),
                      ]
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Row columnInfo(BuildContext context, item) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          toUpperCase(str: item.columnName, name: 'Field名'),
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          item.columnComment != null && item.columnComment != ''
              ? item.columnComment!
              : '中文名',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          toLowerCase(str: item.columnName, name: 'FieldJson'),
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          item.dataType ?? 'Field数据类型',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          '数据字段长度',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          item.dataType ?? '数据库字段',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Text(
          item.columnComment ?? '数据库字段描述',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        // Text(
        //   '搜索条件',
        //   style: FlutterFlowTheme.of(context).bodyText1,
        // ),
        Text(
          '操作',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
      ],
    );
  }
}
