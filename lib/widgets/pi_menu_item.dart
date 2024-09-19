import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/styles.dart';

class PiMenuItem extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? title;
  final Function()? onTap;

  const PiMenuItem({
    this.icon,
    this.iconColor,
    this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 1.sw - 32.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20.w,
              ),
              10.horizontalSpace,
              Expanded(
                child: Text(
                  '$title',
                  style: TextStyle(
                    color: Styles.primaryTextColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              10.horizontalSpace,
              Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Styles.primaryTextColor,
                size: 24.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
