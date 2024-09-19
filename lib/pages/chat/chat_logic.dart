import 'package:fishpi/types/chat.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:fishpi_app/pages/conversation/conversation_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/controller/im.dart';

class ChatLogic extends GetxController {
  final imController = Get.find<IMController>();
  final messageList = <ChatRoomMessage>[].obs;
  final chatMsgList = <ChatData>[].obs;
  final conversationLogic = Get.find<ConversationLogic>();

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
    messageList.value = conversationLogic.messageList;
    messageList.refresh();
    scrollToBottom();
    super.onInit();
  }

  void initChatRoom() async {
    conversationLogic.messageList.listen((data){
      messageList.value = data;
      messageList.refresh();
      scrollToBottom();
    });
    // imController.onRecvNewMessage = (ChatRoomMessage msg) {
    //   messageList.add(msg);
    //   messageList.refresh();
    //   scrollToBottom();
    // };
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      chatRoomController.animateTo(
        chatRoomController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }
}
