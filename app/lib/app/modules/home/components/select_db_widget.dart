import 'package:app/flutter_flow/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class SelectDbWidget extends StatefulWidget {
  const SelectDbWidget({Key? key}) : super(key: key);

  @override
  _SelectDbWidgetState createState() => _SelectDbWidgetState();
}

class _SelectDbWidgetState extends State<SelectDbWidget> {
  SqlToCodeController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '数据库名：',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    FlutterFlowDropDown(
                      options: c.dbnames,
                      initialOption: '请选择数据库',
                      onChanged: (val) => setState(() {
                        c.getTables(val);
                        c.changeDbname(val);
                      }),
                      width: 180,
                      height: 50,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                      hintText: '选择数据库...',
                      icon: FaIcon(
                        FontAwesomeIcons.database,
                      ),
                      fillColor: Color(0xFFEEEEEE),
                      elevation: 2,
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      borderRadius: 0,
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '表名：',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    FlutterFlowDropDown(
                      disabled: c.getTableDisabled.value,
                      options: c.tables,
                      initialOption: '请选择表',
                      onChanged: (val) => setState(() => c.changeTable(val)),
                      width: 180,
                      height: 50,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                      hintText: '选择表...',
                      icon: FaIcon(
                        FontAwesomeIcons.table,
                      ),
                      fillColor: Color(0xFFEEEEEE),
                      elevation: 2,
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      borderRadius: 0,
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
                    ),
                  ],
                ),
              ),
              FFButtonWidget(
                onPressed: () {
                  c.getColumns();
                },
                text: '使用此表创建',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
