import 'package:fishpi_app/routers/navigator.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashLogic extends GetxController {
  final isLogin = false.obs;
  @override
  void onInit() {
    isLogin.value =  PiUtils.getBool('isLogin');
    print('isLogin:${isLogin.value}');
    super.onInit();
  }

  void toStartApp() {
    isLogin.value ? AppNavigator.closeAllToHome() : AppNavigator.startLogin() ;
  }
}
