import 'package:fishpi_app/res/icons.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  final MineLogic logic = Get.put(MineLogic());

  MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Container(
                width: 392.w,
                height: 185.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Styles.commonBorder,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.userInfo.value.name,
                            style: TextStyle(
                              color: Styles.primaryTextColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            logic.userInfo.value.intro,
                            style: TextStyle(
                              color: const Color(0xFFEFEFEF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '# ${logic.userInfo.value.oId}',
                                style: TextStyle(
                                  color: const Color(0xFFEFEFEF),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    PiAvatar(
                      userName: logic.userInfo.value.userName,
                      avatarURL: logic.userInfo.value.avatarURL,
                      width: 70.w,
                      height: 70.w,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
