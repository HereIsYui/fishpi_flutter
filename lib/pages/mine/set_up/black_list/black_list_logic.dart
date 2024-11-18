import 'package:fishpi_app/core/manager/toast.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:get/get.dart';

class BlackListLogic extends GetxController {
  final blackList = [].obs;

  @override
  void onInit() {
    loadBlackList();
    super.onInit();
  }

  void loadBlackList() async {
    blackList.value = await PiUtils.getBlackList();
  }

  removeUser(int index) async {
    await PiUtils.removeBlackList(blackList[index]);
    blackList.removeAt(index);
    ToastManager.showToast('移除成功');
  }
}
