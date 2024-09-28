import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:get/get.dart';

class UserPanelLogic extends GetxController {
  final imController = Get.find<IMController>();
  final isLoading = false.obs;
  final userName = ''.obs;
  final userInfo = UserInfo().obs;
  final tabIndex = 0.obs;

  final userArticles = <ArticleDetail>[].obs;
  final userBreezemoons = <BreezemoonContent>[].obs;

  @override
  void onInit() {
    var args = Get.arguments;
    userName.value = args['userName'] ?? '';
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    isLoading.value = true;
    userInfo.value = await imController.fishpi.getUser(userName.value);
    isLoading.value = false;
    getUserArticles();
    getUserBreezemoons();
  }

  void getUserArticles() async {
    ArticleList res = await imController.fishpi.article.listByUser(
      user: userName.value,
      page: 1,
      size: 15,
    );
    userArticles.value = res.list;
    print(res);
  }

  void getUserBreezemoons() async {
    List<BreezemoonContent> res = await imController.fishpi.breezemoon.list(
      user: userName.value,
      page: 1,
      size: 15,
    );
    userBreezemoons.value = res;
  }

  void toFollow() {
    if(userInfo.value.canFollow == 'yes'){
      userInfo.value.canFollow = 'no';
    }else{
      userInfo.value.canFollow = 'yes';
    };
    // 本来想写关注来着，发现好像没有关注接口
  }

  void toTransfer() {}

  void toChat() {}

  void toSetLabel() {}

  void changeTab(int idx) {
    tabIndex.value = idx;
  }
}
