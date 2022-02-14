import 'package:app/flutter_flow/index.dart';
import 'package:flutter/material.dart';

class FieldInfoWidget extends StatefulWidget {
  const FieldInfoWidget({Key? key}) : super(key: key);

  @override
  _FieldInfoWidgetState createState() => _FieldInfoWidgetState();
}

class _FieldInfoWidgetState extends State<FieldInfoWidget> {
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
                    content: Text('code'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
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
        ],
      ),
    );
  }
}
