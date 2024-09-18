import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forum_detail_logic.dart';

class ForumDetailPage extends StatelessWidget {
  final ForumDetailLogic logic = Get.put(ForumDetailLogic());

  ForumDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
