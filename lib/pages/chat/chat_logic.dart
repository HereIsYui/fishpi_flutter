import 'package:fishpi/fishpi.dart';
import 'package:fishpi/types/chat.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:fishpi_app/core/manager/toast.dart';
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
  final isShowEmoji = false.obs;
  final isShowTools = false.obs;
  final isShowVoice = false.obs;

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
        scrollToBottom(delay: 300);
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
  }

  void scrollToBottom({int? delay}) {
    if (isClose.value) return;
    Future.delayed(Duration(milliseconds: delay ?? 100), () {
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

  void toggleTools() {
    isShowTools.value = !isShowTools.value;
    isShowEmoji.value = false;
    isShowVoice.value = false;
    isShowTools.value ? unFocus() : focus();
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
  }

  void clickSend() async {
    //ToastManager.show(content: '发送中...');
    imController.fishpi.chatroom.send(content.value);
    content.value = '';
    chatRoomControllerText.text = '';
    //ToastManager.dismiss();
  }

  void toggleEmoji() {
    isShowEmoji.value = !isShowEmoji.value;
    isShowTools.value = false;
    isShowVoice.value = false;
    isShowEmoji.value ? unFocus() : focus();
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
  }

  void toggleVoice() {
    isShowVoice.value = !isShowVoice.value;
    isShowTools.value = false;
    isShowEmoji.value = false;
    isShowVoice.value ? unFocus() : focus();
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
  }

  void closeAllTools() {
    isShowEmoji.value = false;
    isShowTools.value = false;
    isShowVoice.value = false;
    unFocus();
  }

  void loadEmojis() async {
    emojiList.value = imController.fishpi.emoji.defaultEmojis;
    diyEmojiList.value = await imController.fishpi.emoji.get();
    emojiList.refresh();
    diyEmojiList.refresh();
    print(diyEmojiList.toJson());
  }

  void clickUserAvatar(String userName) {
    AppNavigator.toUserPanel(userName: userName);
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
