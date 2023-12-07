import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/chat.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatController chatController = Get.put(ChatController());


  @override
  void initState() {
    print(chatController.fishpi.token);
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


}
