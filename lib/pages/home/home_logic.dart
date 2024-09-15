import 'package:fishpi_app/core/controller/im.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:get/get.dart';


class HomeLogic extends GetxController {
  final imController = Get.find<IMController>();
  final token = ''.obs;
  @override
  void onInit(){
    token.value = PiUtils.getString('token');
    initChat();
    super.onInit();
  }

  void initChat(){
    imController.init(token.value);
    imController.chatInit();
  }
}
