import 'package:fishpi/fishpi.dart';
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
  final userInfo = UserInfo().obs;

  final isGroup = false.obs;
  final userName = ''.obs;
  final userID = ''.obs;
  final isClose = true.obs;
  final isShowEmoji = false.obs;

  ScrollController chatRoomController = ScrollController();
  TextEditingController chatRoomControllerText = TextEditingController();
  FocusNode chatRoomFocusNode = FocusNode();

  final content = ''.obs;

  final emojiList = {}.obs;
  final diyEmojiList = <String>[].obs;
  final emojiIndex = 0.obs;

  @override
  void onInit() {
    initChatRoom();
    loadEmojis();
    var args = Get.arguments;
    isGroup.value = args['isGroup'] ?? false;
    userName.value = args['userName'] ?? '聊天室';
    userID.value = args['userID'] ?? '';
    messageList.value = conversationLogic.messageList;
    messageList.refresh();
    imController.fishpi.user.info().then((value) => userInfo.value = value);
    isClose.value = false;
    chatRoomFocusNode.addListener(() {
      if (chatRoomFocusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    scrollToBottom();
    super.onInit();
  }

  void initChatRoom() async {
    conversationLogic.messageList.listen((data) {
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
    if (isClose.value) return;
    Future.delayed(const Duration(milliseconds: 100), () {
      chatRoomController.animateTo(
        chatRoomController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  void onInput(String text) {
    content.value = text;
  }

  void showTools() {}

  void clickSend() {
    print('发送消息：${content.value}');
    imController.fishpi.chatroom.send(content.value);
    content.value = '';
    chatRoomControllerText.text = '';
  }

  void toggleEmoji() {
    isShowEmoji.value = !isShowEmoji.value;
    unFocus();
  }

  void closeAllTools() {
    isShowEmoji.value = false;
    unFocus();
  }

  void loadEmojis() async {
    emojiList.value = imController.fishpi.emoji.defaultEmojis;
    diyEmojiList.value = await imController.fishpi.emoji.get();
    emojiList.refresh();
    diyEmojiList.refresh();
    print(diyEmojiList.toJson());
  }

  focus() => FocusScope.of(Get.context!).requestFocus(chatRoomFocusNode);

  unFocus() => FocusScope.of(Get.context!).requestFocus(FocusNode());

  @override
  void onClose() {
    isClose.value = true;
    chatRoomController.dispose();
    print('聊天页面关闭');
    super.onClose();
  }
}
