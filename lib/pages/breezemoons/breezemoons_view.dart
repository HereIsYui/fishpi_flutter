import 'package:fishpi_app/res/icons.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:fishpi_app/widgets/pi_image.dart';
import 'package:fishpi_app/widgets/pi_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../res/view.dart';
import 'breezemoons_logic.dart';

class BreezemoonsPage extends StatelessWidget {
  final BreezemoonsLogic logic = Get.put(BreezemoonsLogic());

  BreezemoonsPage({Key? key}) : super(key: key);

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
            header: Views.buildHeader(),
            footer: Views.buildFooter(),
            onRefresh: logic.onRefresh,
            onLoading: logic.onLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  height: 36.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 290.w,
                        height: 36.h,
                        child: PiInput(
                          controller: logic.textEditingController,
                          onInputChanged: logic.onInputChanged,
                          hintText: '随便说说...',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Icon(
                        FishIcon.send,
                        size: 30.w,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 20.h),
                    itemBuilder: _buildBreezemoonList,
                    itemCount: logic.list.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreezemoonList(
    BuildContext context,
    int idx,
  ) {
    final item = logic.list[idx];
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Styles.commonBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PiAvatar(
                userName: item.authorName,
                avatarURL: item.thumbnailURL48,
                width: 35.w,
                height: 35.w,
              ),
              20.horizontalSpace,
              Text(
                item.authorName,
                style: TextStyle(
                  color: Styles.primaryTextColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(child: 1.horizontalSpace),
              Text(
                item.timeAgo,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFC4C4C4),
                ),
              ),
            ],
          ),
          handleBreeze(item.content),
        ],
      ),
    );
  }

  /// 清风明月内容处理
  Widget handleBreeze(content) {
    var document = parse(content);
    List<Widget> list = [];

    /// 处理文本
    document.querySelectorAll("p,h1,h2,h3,h4,h5,h6,h7").forEach((element) {
      if (element.text.isEmpty) return;
      list.add(
        Text(
          element.text,
          style: TextStyle(
            color: Styles.primaryTextColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });

    /// 处理图片
    document.querySelectorAll("img").forEach((element) {
      if (element.attributes['src']!.isEmpty) return;
      list.add(
        PiImage(
          imgUrl: element.attributes['src']!,
          width: 1.sw,
          height: 180.h,
        ),
      );
    });
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        children: list,
      ),
    );
  }
}
