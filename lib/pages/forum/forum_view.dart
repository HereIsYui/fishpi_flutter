import 'package:fishpi/types/article.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'forum_logic.dart';

class ForumPage extends StatelessWidget {
  final ForumLogic logic = Get.put(ForumLogic());

  ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: SmartRefresher(
            controller: logic.refresherController,
            header: const WaterDropMaterialHeader(
              backgroundColor: Styles.primaryColor,
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  // body = Text("pull up load");
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.loading) {
                  body = Text("加载中");
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败!");
                  // body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("加载中");
                  // body = const CupertinoActivityIndicator();
                } else {
                  body = Text("- 我是有底线的 -");
                  // body = const SizedBox();
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            onRefresh: logic.onRefresh,
            onLoading: logic.onLoading,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20.h),
              itemBuilder: _buildArticleList,
              itemCount: logic.list.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleList(BuildContext context, int idx) {
    ArticleDetail article = logic.list[idx];
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          border: Styles.commonBorder,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            if (article.thumbnailURL != '')
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  topRight: Radius.circular(14.r),
                ),
                child: Image.network(
                  PiUtils.filterImageWithSize(
                    article.thumbnailURL,
                    width: 750,
                    height: 360,
                  ),
                  width: 1.sw,
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.titleEmojUnicode,
                          style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                            color: Styles.primaryTextColor,
                          ),
                        ),
                        Text(
                          article.previewContent,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PiAvatar(
                    userName: article.authorName,
                    avatarURL: article.thumbnailURL210,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
