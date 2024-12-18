import 'package:fishpi_app/core/manager/black_list.dart';
import 'package:fishpi_app/core/manager/toast.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BlackListLogic extends GetxController {
  final blackList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    await BlackList.init();
    blackList.value = await BlackList.blackList;
  }

  removeUser(int index) async {
    BlackList.removeUser(index);
  }

  @override
  void dispose() {
    BlackList.dispose();
    super.dispose();
  }
}
