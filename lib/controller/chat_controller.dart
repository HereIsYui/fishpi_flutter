import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late Fishpi fishpi;
  late List<ChatData> chatList;

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getChatList() async {
    chatList = await fishpi.chat.list();
    print(chatList.toString());
    update();
  }
}
