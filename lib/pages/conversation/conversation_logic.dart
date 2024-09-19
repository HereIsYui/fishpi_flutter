import 'package:fishpi/types/chat.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:get/get.dart';

import '../../core/controller/im.dart';

class ConversationLogic extends GetxController {
  final imController = Get.find<IMController>();
  final chatList = <ChatData>[].obs;
  final messageList = <ChatRoomMessage>[].obs;

  @override
  void onInit() {
    messageList.add(ChatRoomMessage());
    initChatList();
    super.onInit();
  }

  void initChatList() async {
    List<ChatData> list = await imController.fishpi.chat.list();
    chatList.value = list;
    imController.onRecvNewMessage = (ChatRoomMessage msg) {
      messageList.add(msg);
      print(msg.toJson());
      messageList.refresh();
    };
  }
}
