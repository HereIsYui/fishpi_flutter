import 'package:fishpi/types/chat.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/controller/im.dart';

class ChatLogic extends GetxController {
  final imController = Get.find<IMController>();
  final messageList = <ChatRoomMessage>[].obs;
  final chatMsgList = <ChatData>[].obs;

  final isGroup = false.obs;
  final userName = ''.obs;
  final userID = ''.obs;
  
  ScrollController chatRoomController = ScrollController();

  @override
  void onInit() {
    initChatRoom();
    var args = Get.arguments;
    isGroup.value = args['isGroup'] ?? false;
    userName.value = args['userName'] ?? '聊天室';
    userID.value = args['userID'] ?? '';
    print(args);
    super.onInit();
  }

  void initChatRoom() async {
    imController.onRecvNewMessage = (ChatRoomMessage msg) {
      messageList.add(msg);
      print(msg.toJson());
      messageList.refresh();
      // 延迟100ms
      Future.delayed(Duration(milliseconds: 100), () {
        chatRoomController.jumpTo(chatRoomController.position.maxScrollExtent);
      });
    };
  }
}
