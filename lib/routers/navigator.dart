import 'package:get/get.dart';
import 'pages.dart';

class AppNavigator {
  AppNavigator._();

  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void closeAllToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  static void toForumDetail({String? oId}) =>
      Get.toNamed(AppRoutes.forumDetail, arguments: {
        "oId": oId,
      });

  static void toChat({
    isGroup = false,
    String? userName,
    String? userID,
  }) =>
      Get.toNamed(AppRoutes.chat, arguments: {
        "isGroup": isGroup,
        "userName": userName,
        "userID": userID,
      });

  /// 设置页面
  static void toSetting() => Get.toNamed(AppRoutes.setUp);
  /// 关于
  static void toAboutUs() => Get.toNamed(AppRoutes.about);
}
