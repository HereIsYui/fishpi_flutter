import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'conversation_logic.dart';

class ConversationPage extends StatelessWidget {
  final ConversationLogic logic = Get.put(ConversationLogic());

  ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
