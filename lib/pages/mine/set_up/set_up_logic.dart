import 'package:fishpi_app/routers/navigator.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:get/get.dart';

class SetUpLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void toBlackPage() {
    AppNavigator.toBlackList();
  }

  void toFeedBackPage() {
    AppNavigator.toFeedback();
  }

  void toComplaint() {
    AppNavigator.toComplaint();
  }

  void toAboutPage() {
    AppNavigator.toAboutUs();
  }

  void logout() {
    PiUtils.clear();
    AppNavigator.startLogin();
  }
}
