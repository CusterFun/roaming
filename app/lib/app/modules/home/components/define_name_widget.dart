import 'package:app/flutter_flow/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class DefineNameWidget extends StatefulWidget {
  const DefineNameWidget({Key? key}) : super(key: key);

  @override
  _DefineNameWidgetState createState() => _DefineNameWidgetState();
}

class _DefineNameWidgetState extends State<DefineNameWidget> {
  late TextEditingController abbreviationController;
  late TextEditingController structNameController;
  late TextEditingController tableNameController;
  late TextEditingController descriptionController;
  late TextEditingController packageNameController;
  bool autoCreateApiToSqlValue = false;
  bool autoMoveFileValue = false;
  final formKey = GlobalKey<FormState>();
  final SqlToCodeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    abbreviationController = TextEditingController();
    structNameController = TextEditingController();
    tableNameController = TextEditingController();
    descriptionController = TextEditingController();
    packageNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                  Text(controller.structName.value),
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
                              initialValue: controller.structName.value,
                              onChanged: (_) => EasyDebounce.debounce(
                                'structNameController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              // controller: structNameController,
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
                                suffixIcon: structNameController.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () => setState(
                                          () => structNameController.clear(),
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      )
                                    : null,
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
                              onChanged: (_) => EasyDebounce.debounce(
                                'tableNameController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              controller: tableNameController,
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
                                suffixIcon: tableNameController.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () => setState(
                                          () => tableNameController.clear(),
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      )
                                    : null,
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
                              onChanged: (_) => EasyDebounce.debounce(
                                'abbreviationController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              controller: abbreviationController,
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
                                suffixIcon: abbreviationController
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () => setState(
                                          () => abbreviationController.clear(),
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      )
                                    : null,
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
                              onChanged: (_) => EasyDebounce.debounce(
                                'descriptionController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              controller: descriptionController,
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
                                suffixIcon: descriptionController
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () => setState(
                                          () => descriptionController.clear(),
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      )
                                    : null,
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
                              onChanged: (_) => EasyDebounce.debounce(
                                'packageNameController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              controller: packageNameController,
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
                                suffixIcon: packageNameController
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () => setState(
                                          () => packageNameController.clear(),
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      )
                                    : null,
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
                              value: autoCreateApiToSqlValue,
                              onChanged: (newValue) => setState(
                                  () => autoCreateApiToSqlValue = newValue!),
                              title: Text(
                                '创建 API',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Color(0xFF707070),
                            ),
                            child: CheckboxListTile(
                              value: autoMoveFileValue,
                              onChanged: (newValue) =>
                                  setState(() => autoMoveFileValue = newValue!),
                              title: Text(
                                '移动文件',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
