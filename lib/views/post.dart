import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi/types/article.dart';
import 'package:fishpi_app/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/util.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  final PostController postController = Get.put(PostController());
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
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: GetBuilder<PostController>(builder: (controller) {
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
          tagList.add(
            GestureDetector(
                onTap: () {
                  print('点击了标签: ${tagObjs[i].title}');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    tagObjs[i].title,
                    style: TextStyle(
                        color: (tagObjs[i].title == '新人报道' ||
                                tagObjs[i].title == '新人报到')
                            ? Colors.red
                            : Colors.grey,
                        fontSize: 10),
                  ),
                )),
          );
        }

        /// 上面是处理标签的代码
        return GestureDetector(
          onTap: () {
            print('点击了文章:${postController.postList.list[index].oId}');
          },
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 4,
                        style: BorderStyle.solid),
                    left: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    right: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      postController.postList.list[index].titleEmoj,
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
                    trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 48.w,
                          height: 48.w,
                          child: Image.network(
                            postController
                                .postList.list[index].author.avatarURL,
                            fit: BoxFit.cover,
                            width: 48.w,
                            height: 48.w,
                          ),
                        )),
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
                            children: [
                              const Icon(
                                Icons.chat_bubble,
                                color: Colors.black,
                                size: 10,
                              ),
                              Text(
                                postController.postList.list[index].commentCnt
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.heart_broken,
                                color: Colors.black,
                                size: 10,
                              ),
                              Text(
                                postController.postList.list[index].thankCnt
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
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
