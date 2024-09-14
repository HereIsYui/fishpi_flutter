import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  final ChatLogic logic = Get.put(ChatLogic());

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
