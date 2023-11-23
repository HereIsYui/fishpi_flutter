import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late Fishpi fishpi;
  ArticleList postList = ArticleList();

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getArticleList(int page) async {
    ArticleList list = await fishpi.article.list(page: page,type: ArticleListType.Recent);
    print(list.pagination.toJson());
    if(page == 1){
      postList = list;
    }else{
      postList.list += list.list;
    }
    update();
  }
}
