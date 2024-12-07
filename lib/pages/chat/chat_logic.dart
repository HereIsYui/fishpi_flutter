import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/pages/conversation/conversation_logic.dart';
import 'package:fishpi_app/routers/navigator.dart';
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
  final isSeeHistory = false.obs;

  ScrollController chatRoomController = ScrollController();
  TextEditingController chatRoomControllerText = TextEditingController();
  FocusNode chatRoomFocusNode = FocusNode();

  final content = ''.obs;

  get emojiList => imController.fishpi.emoji.defaultEmojis;
  final diyEmojiList = <String>[].obs;
  final emojiIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
    chatRoomController.addListener(() {
      if (chatRoomController.position.maxScrollExtent -
              chatRoomController.position.pixels >=
          100) {
        isSeeHistory.value = true;
      } else {
        isSeeHistory.value = false;
      }
      print(isSeeHistory.value);
    });
    scrollToBottom();
  }

  void initChatRoom() async {
    conversationLogic.messageList.listen((data) {
      messageList.value = data;
      messageList.refresh();
      scrollToBottom();
    });
  }

  void scrollToBottom({int? delay}) {
    if (isClose.value || isSeeHistory.value) return;
    Future.delayed(Duration(milliseconds: delay ?? 200), () {
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

  void clickUserAvatar(String userName) {
    AppNavigator.toUserPanel(userName: userName);
  }

  void clickSend() async {
    //ToastManager.show(content: '发送中...');
    imController.fishpi.chatroom.send(content.value);
    content.value = '';
    chatRoomControllerText.text = '';
    //ToastManager.dismiss();
  }

  void loadEmojis() async {
    diyEmojiList.value = await imController.fishpi.emoji.get();
    emojiList.refresh();
    diyEmojiList.refresh();
  }

  @override
  void onClose() {
    isClose.value = true;
    chatRoomController.dispose();
    print('聊天页面关闭');
    super.onClose();
  }
}
