import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'set_up_logic.dart';

class SetUpPage extends StatelessWidget {
  final SetUpLogic logic = Get.put(SetUpLogic());

  SetUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
