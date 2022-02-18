import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:get/get.dart';

import '../controllers/sql_to_code_controller.dart';

class PreviewDialog extends StatefulWidget {
  const PreviewDialog({Key? key}) : super(key: key);

  @override
  State<PreviewDialog> createState() => _PreviewDialogState();
}

class _PreviewDialogState extends State<PreviewDialog>
    with SingleTickerProviderStateMixin {
  SqlToCodeController controller = Get.find();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: controller.codeTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        _buildTabBar(),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: _buildTableBarView(),
        ),
      ]),
    );
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        isScrollable: false,
        controller: _tabController,
        labelColor: Colors.blue,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.orangeAccent,
        tabs: controller.codeTabs.map((e) => Tab(text: e)).toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: controller.codeTmps
          .map(
            (e) => Container(
              child: Stack(
                children: [
                  Markdown(
                    // selectable: true,
                    data: e,
                    extensionSet: md.ExtensionSet(
                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                      [
                        md.EmojiSyntax(),
                        ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: TextButton(
                      child: Text('Copy'),
                      onPressed: () {
                        FlutterClipboard.copy(e).then(
                            (value) => Get.snackbar('提示', 'copy success'));
                      },
                    ),
                  )
                ],
              ),
              // Text(e, style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
          .toList());
}
