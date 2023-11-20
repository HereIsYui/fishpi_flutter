import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  Fishpi fishpi = Fishpi();
  late ArticleList postList;

  Future<ArticleList> getArticleList() async {
    ArticleList list = await fishpi.article.list(type: ArticleListType.Recent);
    return list;
  }
}
