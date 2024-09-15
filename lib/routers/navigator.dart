import 'package:get/get.dart';
import 'pages.dart';

class AppNavigator {
  AppNavigator._();

  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void closeAllToHome(){
    Get.offAllNamed(AppRoutes.home);
  }
}