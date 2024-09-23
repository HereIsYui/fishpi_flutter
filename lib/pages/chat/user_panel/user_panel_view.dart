import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_panel_logic.dart';

class UserPanelPage extends StatelessWidget {
  final UserPanelLogic logic = Get.put(UserPanelLogic());

  UserPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
