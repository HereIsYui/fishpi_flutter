import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
