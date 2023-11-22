import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late Fishpi fishpi;
  late ArticleList postList;

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getArticleList() async {
    postList = await fishpi.article.list(type: ArticleListType.Recent);
  }
}
