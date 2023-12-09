import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:fishpi_app/components/avatar.dart';
import 'package:fishpi_app/controller/chat.dart';
import 'package:fishpi_app/router/app_router.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

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
      itemCount: chatController.chatList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 1.sw,
              height: 64.h,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Avatar(
                    image: 'assets/images/logo.png',
                    size: 48.w,
                    isAssets: true,
                  ),
                  Container(
                    width: 255.w,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          '聊天室',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        chatController.chatRoomMsg.isNotEmpty
                            ? handleLastMsg(
                                chatController.chatRoomMsg[chatController.chatRoomMsg.length-1])
                            : const Text(''),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          FpUtil.getChatTime('2023-12-09 13:03:00'),
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRouters.chatroom);
            },
            child: Container(
              width: 1.sw,
              height: 64.h,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Avatar(
                    image: chatController.chatList[index - 1].receiverAvatar,
                    size: 48.w,
                  ),
                  Container(
                    width: 255.w,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          chatController.chatList[index - 1].receiverUserName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          chatController.chatList[index - 1].preview,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(71, 74, 87, 1)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          FpUtil.getChatTime(
                              chatController.chatList[index - 1].time),
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget handleLastMsg(ChatRoomMessage msg) {
    var document = parse(msg.content);
    String chatMsg = '';

    /// 处理文本
    document.querySelectorAll("p,h1,h2,h3,h4,h5,h6,h7").forEach((element) {
      if (element.text.isEmpty) return;
      chatMsg = '${msg.userName}:${element.text}';
    });

    /// 处理图片
    document.querySelectorAll("img").forEach((element) {
      if (element.attributes['src']!.isEmpty) return;
      chatMsg = '${msg.userName}:[图片]';
    });
    return Text(
      chatMsg,
      style: const TextStyle(
        fontSize: 15,
        color: Color.fromRGBO(71, 74, 87, 1),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
