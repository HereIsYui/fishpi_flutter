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
    loadHistoryMessage();
    super.onInit();
  }

  void loadHistoryMessage() async {
    List<ChatData> list = await imController.fishpi.chat.list();
    chatList.value = list;
    chatList.refresh();
    imController.fishpi.chatroom.more(1).then((value) {
      value = value.reversed.toList();
      messageList.addAll(value);
      messageList.refresh();
      initChat();
    });
  }

  void initChat(){
    imController.onRecvNewMessage = (ChatRoomMessage msg) {
      messageList.add(msg);
      print(msg);
      messageList.refresh();
    };
  }
}
