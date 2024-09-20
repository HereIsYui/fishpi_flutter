import 'package:fishpi/types/article.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:get/get.dart';

class ForumDetailLogic extends GetxController {
  final imController = Get.find<IMController>();
  final oId = ''.obs;
  final article = ArticleDetail().obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    var args = Get.arguments;
    oId.value = args['oId'] ?? '';
    initArticleInfo();
    super.onInit();
  }

  void initArticleInfo() async {
    isLoading.value = true;
    ArticleDetail res = await imController.fishpi.article.detail(oId.value);
    isLoading.value = false;
    article.value = res;
    print(article.value.toJson());
  }
}
