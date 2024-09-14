import 'package:fishpi_app/widgets/pi_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PiTitleBar.home(title: '聊天',)
        ],
      ),
    );
  }
}
