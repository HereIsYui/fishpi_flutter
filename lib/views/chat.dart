import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi_app/controller/chat_controller.dart';
import 'package:fishpi_app/router/app_router.dart';
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
  void initState() {
    super.initState();
    token = FpUtil.getString('token');
    chatController.init(token);
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
    );
    loadData();
  }

  void loadData() {
    chatController.getChatList();
    chatController.chetInit();
    _controller.finishRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: EasyRefresh.builder(
          controller: _controller,
          header: ClassicHeader(
            dragText: 'Pull to refresh'.tr,
            armedText: 'Release ready'.tr,
            readyText: 'Refreshing...'.tr,
            processingText: 'Refreshing...'.tr,
            processedText: 'Succeeded'.tr,
            noMoreText: 'No more'.tr,
            failedText: 'Failed'.tr,
            messageText: 'Last updated at %T'.tr,
            safeArea: false,
            textStyle: const TextStyle(color: Colors.grey),
          ),
          onRefresh: () async {
            loadData();
          },
          childBuilder: (BuildContext context, ScrollPhysics physics) {
            return Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.white,
                child: GetBuilder<ChatController>(builder: (controller) {
                  return chatController.chatList.isNotEmpty
                      ? _chatList(physics)
                      : const Text(
                          'is loading',
                          style: TextStyle(color: Colors.black),
                        );
                }));
          },
        ),
      ),
    );
  }

  Widget _chatList(physics) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: physics,
      itemCount: chatController.chatList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRouters.chatroom);
          },
          child: Container(
            width: 1.sw,
            height: 64.h,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.network(
                      chatController.chatList[index].receiverAvatar,
                      width: 48.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatController.chatList[index].receiverUserName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        chatController.chatList[index].preview,
                        style: const TextStyle(fontSize: 15,color: Color.fromRGBO(71, 74, 87, 1)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      chatController.chatList[index].time,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
