import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Views{
  static buildHeader(){
    return const WaterDropMaterialHeader(
      backgroundColor: Styles.primaryColor,
    );
  }
  static buildFooter(){
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          // body = Text("pull up load");
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.loading) {
          body = Text("加载中");
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败!");
          // body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.canLoading) {
          body = Text("加载中");
          // body = const CupertinoActivityIndicator();
        } else {
          body = Text("- 我是有底线的 -");
          // body = const SizedBox();
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}