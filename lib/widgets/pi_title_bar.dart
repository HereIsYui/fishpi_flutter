import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PiTitleBar extends StatelessWidget {
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
      color: backgroundColor ?? Styles.primaryColor,
      padding: EdgeInsets.only(top: mq.padding.top),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: showUnderline
            ? const BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(color: Colors.black, width: .5),
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
              ),
            ],
          ),
        ),
        height = 48.h,
        showUnderline = true,
        left = null,
        right = null,
        backgroundColor = null;
}
