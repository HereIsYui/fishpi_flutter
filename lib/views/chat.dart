import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Text(
          'Say hello'.tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
