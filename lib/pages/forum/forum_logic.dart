import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumLogic extends GetxController {
  final refresherController = RefreshController();
  final imController = Get.find<IMController>();

  final list = <ArticleDetail>[].obs;
  final page = 0.obs;

  @override
  void onInit() {
    initArticle();
    super.onInit();
  }

  void initArticle() async{
    ArticleList res = await imController.fishpi.article.list(
      type: ArticleListType.Reply,
      page: page.value,
    );
    list.value = res.list;
    list.refresh();
    refresherController.refreshCompleted();
  }

  void onRefresh(){
    initArticle();
  }
}
