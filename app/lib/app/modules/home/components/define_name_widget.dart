import 'package:app/flutter_flow/index.dart';
import 'package:app/utils/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class DefineNameWidget extends StatefulWidget {
  const DefineNameWidget({Key? key}) : super(key: key);

  @override
  _DefineNameWidgetState createState() => _DefineNameWidgetState();
}

class _DefineNameWidgetState extends State<DefineNameWidget> {
  final SqlToCodeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.defineNameKey.value,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: GetX<SqlToCodeController>(
            init: SqlToCodeController(),
            initState: (_) {},
            builder: (controller) {
              if (controller.structName.value != '') {
                controller.tableName.value =
                    toSQLLine(controller.structName.value);
                controller.abbreviation.value =
                    toHump(controller.structName.value);
                controller.description.value =
                    '${toHump(controller.structName.value)}表';
                controller.packageName.value =
                    toHump(controller.structName.value);
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: AutoSizeText(
                                'Struct名称',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: toUpperCase(
                                    str: toHump(controller.structName.value)),
                                onSaved: (String? val) {
                                  controller.structName.value = val!;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '结构体名称',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.account_tree_outlined,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: AutoSizeText(
                                'TableName',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: controller.tableName.value,
                                onSaved: (String? val) {
                                  controller.tableName.value = val!;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '指定表名',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.pivot_table_chart,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: AutoSizeText(
                                'Struct简称',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: controller.abbreviation.value,
                                onSaved: (String? val) {
                                  controller.abbreviation.value = val!;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '简称会作为入参对象名和路由group',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.clear_all_outlined,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: AutoSizeText(
                                'Struct中文名称',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: controller.description.value,
                                onSaved: (String? val) {
                                  controller.description.value = val!;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '中文描述作为自动api描述',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.more,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: AutoSizeText(
                                '文件名称',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: controller.packageName.value,
                                onSaved: (String? val) {
                                  controller.packageName.value = val!;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText:
                                      '生成文件的默认名称(建议为驼峰格式,首字母小写,如sysXxxXxxx)',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.file_copy,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFF707070),
                              ),
                              child: CheckboxListTile(
                                value: controller.autoCreateApiToSql.value,
                                onChanged: (newValue) => setState(() =>
                                    controller.autoCreateApiToSql.value =
                                        newValue!),
                                title: Text(
                                  '创建 API',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFF707070),
                              ),
                              child: CheckboxListTile(
                                value: controller.autoMoveFile.value,
                                onChanged: (newValue) => setState(() =>
                                    controller.autoMoveFile.value = newValue!),
                                title: Text(
                                  '移动文件',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center();
              }
            }),
      ),
    );
  }
}
