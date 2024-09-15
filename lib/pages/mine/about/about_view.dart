import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_logic.dart';

class AboutPage extends StatelessWidget {
  final AboutLogic logic = Get.put(AboutLogic());

  AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
