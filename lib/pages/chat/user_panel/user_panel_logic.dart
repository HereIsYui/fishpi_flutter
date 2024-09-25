import 'package:fishpi/types/user.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:get/get.dart';


class UserPanelLogic extends GetxController {
  final imController = Get.find<IMController>();
  final isLoading = false.obs;
  final userName = ''.obs;
  final userInfo = UserInfo().obs;

  @override
  void onInit(){
  var args = Get.arguments;
    userName.value = args['userName'] ?? '';
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async{
    isLoading.value = true;
    userInfo.value = await imController.fishpi.getUser(userName.value);
    isLoading.value = false;
  }
}
