import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi/types/article.dart';
import 'package:fishpi_app/controller/article.dart';
import 'package:fishpi_app/utils/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common_style/style.dart';
import '../components/avatar.dart';
import '../components/tag.dart';
import '../utils/util.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin {
  final ArticleController postController = Get.put(ArticleController());
  late EasyRefreshController _controller;
  int page = 1;
  String token = "";

  @override
  void initState() {
    super.initState();
    token = FpUtil.getString('token');
    postController.init(token);
    _controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    loadData();
  }

  void loadData() {
    postController.getArticleList(page);
    page == 1 ? _controller.finishRefresh() : _controller.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: EasyRefresh.builder(
          controller: _controller,
          header: ClassicHeader(
            dragText: 'Pull to refresh'.tr,
            armedText: 'Release ready'.tr,
            readyText: 'Refreshing...'.tr,
            processingText: 'Refreshing...'.tr,
            processedText: 'Succeeded'.tr,
            noMoreText: 'No more'.tr,
            failedText: 'Failed'.tr,
            messageText: 'Last updated at %T'.tr,
            safeArea: false,
            textStyle: const TextStyle(color: Colors.grey),
          ),
          footer: ClassicFooter(
            position: IndicatorPosition.behind,
            textStyle: const TextStyle(color: Colors.grey),
            dragText: 'Pull to load'.tr,
            armedText: 'Release ready'.tr,
            readyText: 'Loading...'.tr,
            processingText: 'Loading...'.tr,
            processedText: 'Succeeded'.tr,
            noMoreText: 'No more'.tr,
            failedText: 'Failed'.tr,
            messageText: 'Last updated at %T'.tr,
            // infiniteOffset: null,
          ),
          onRefresh: () async {
            page = 1;
            loadData();
          },
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 0), () {
              print('已到达世界边缘');
              if (postController.postList.pagination.count >
                  postController.postList.list.length) {
                page++;
                loadData();
              } else {
                _controller.finishLoad(IndicatorResult.noMore);
              }
            });
          },
          childBuilder: (BuildContext context, ScrollPhysics physics) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              color: Colors.white,
              child: GetBuilder<ArticleController>(builder: (controller) {
                return postController.postList.list.isNotEmpty
                    ? _articleList(physics)
                    : const Text(
                        'is loading',
                        style: TextStyle(color: Colors.black),
                      );
              }),
            );
          },
        ),
      ),
    );
  }


  Widget _articleList(physics) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: physics,
      itemCount: postController.postList.list.length,
      itemBuilder: (context, index) {
        /// 下面是处理标签的代码
        List<Widget> tagList = [];
        List<ArticleTag> tagObjs = postController.postList.list[index].tagObjs;
        for (var i = 0; i < tagObjs.length; i++) {
          tagList.add(Tag(
            tagObjs[i],
            onTap: () {
              print('点击了标签: ${tagObjs[i].title}');
            },
            iconSize: 12.w,
            fontSize: 10
          ));
        }

        /// 上面是处理标签的代码
        return GestureDetector(
          onTap: () {
            print('点击了文章:${postController.postList.list[index].oId}');
          },
          child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: const BoxDecoration(
                  border: CommonStyle.commonBorder,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      postController.postList.list[index].titleEmoj,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    subtitle: Text(
                      postController.postList.list[index].previewContent,
                      style: TextStyle(
                        color: const Color.fromRGBO(74, 74, 87, 1),
                        fontSize: 15.sp,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Avatar(
                      size: 48.w,
                      image:
                          postController.postList.list[index].author.avatarURL,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: tagList,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                FishIcon.reply,
                                color: Colors.black,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                postController.postList.list[index].commentCnt
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FishIcon.like,
                                color: Colors.black,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                postController.postList.list[index].thankCnt
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
