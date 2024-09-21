import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/icons.dart';

class PiTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final double? height;
  final Color? backgroundColor;
  final bool showUnderline;

  const PiTitleBar(
      {this.left,
      this.center,
      this.right,
      this.height,
      this.backgroundColor,
      this.showUnderline = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      color: backgroundColor ?? Styles.titleBarColor,
      padding: EdgeInsets.only(top: mq.padding.top),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: showUnderline
            ? const BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(color: Colors.black, width: 2),
                ),
              )
            : null,
        child: Row(
          children: [
            if (null != left) left!,
            if (null != center) center!,
            if (null != right) right!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 48.h);

  PiTitleBar.home({
    super.key,
    String? title,
  })  : center = Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Styles.titleBarStyle,
              ),
            ],
          ),
        ),
        height = 48.h,
        showUnderline = true,
        left = GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: Image.asset(
              'assets/images/scan.png',
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        right = GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: Image.asset(
              'assets/images/notice.png',
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        backgroundColor = null;

  PiTitleBar.back({
    super.key,
    String? title,
  })  : center = Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Styles.titleBarStyle,
              ),
            ],
          ),
        ),
        height = 48.h,
        showUnderline = true,
        left = GestureDetector(
          onTap: () {
            Get.back();
          },
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Styles.primaryTextColor,
            ),
          ),
        ),
        right = GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 24.w,
            height: 24.w,
          ),
        ),
        backgroundColor = null;
}
