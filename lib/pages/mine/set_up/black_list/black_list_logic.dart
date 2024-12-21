import 'package:fishpi_app/core/sql/black_list.dart';
import 'package:get/get.dart';

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
