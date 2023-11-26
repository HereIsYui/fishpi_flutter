import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi_app/controller/chat_controller.dart';
import 'package:fishpi_app/utils/util.dart';
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
  final ChatController chatController = Get.put(ChatController());
  late EasyRefreshController _controller;
  String token = "";

  @override
  void initState(){
    super.initState();
    token =  FpUtil.getString('token');
    chatController.init(token);
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
    );
    loadData();
  }

  void loadData(){
    chatController.getChatList();
    _controller.finishRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Say hello'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
