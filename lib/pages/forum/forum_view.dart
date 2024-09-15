import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forum_logic.dart';

class ForumPage extends StatelessWidget {
  final ForumLogic logic = Get.put(ForumLogic());

  ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('forum page'),
    );
  }
}
