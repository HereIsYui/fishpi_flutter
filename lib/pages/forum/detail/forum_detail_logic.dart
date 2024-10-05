import 'package:fishpi/types/article.dart';
import 'package:fishpi/types/types.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:fishpi_app/core/manager/toast.dart';
import 'package:fishpi_app/widgets/pi_editer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/pop_route.dart';

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

  void toReward() async {
    ResponseResult res =
        await imController.fishpi.article.reward(article.value.oId);
    if (res.success) {
      initArticleInfo();
    }else{
      ToastManager.showToast(res.msg);
    }
  }

  void showEdit() async{
    Navigator.push(
      Get.context!,
      PopRoute(
        child: PiEditWidget(
          onEditingCompleteText: (text) async{
            String context = text;
            if (context.trim() == '') {
              return;
            } else {
              CommentPost data = CommentPost(
                content: context,
                articleId: article.value.oId,
              );
              await imController.fishpi.comment.send(data);
            }
          },
        ),
      ),
    );

  }
}
