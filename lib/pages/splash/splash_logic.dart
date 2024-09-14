import 'package:fishpi_app/routers/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashLogic extends GetxController {


  @override
  void onInit() {

    super.onInit();
  }

  void toStartApp(){
    AppNavigator.startLogin();
  }
}
