import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Views {
  static buildHeader() {
    return const WaterDropMaterialHeader(
      backgroundColor: Styles.primaryColor,
    );
  }

  static buildFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("上拉加载",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ));
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("加载失败！点击重试！",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ));
        } else if (mode == LoadStatus.canLoading) {
          body = const Text("松手,加载更多!",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ));
        } else {
          body = const Text("- 我是有底线的 -",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ));
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
