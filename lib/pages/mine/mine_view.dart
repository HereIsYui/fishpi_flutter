import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/pi_menu_item.dart';
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
                width: 1.sw - 32.w,
                height: 185.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Styles.commonBorder,
                  color: const Color(0xFF00C6AE),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                    '# ${logic.userInfo.value.userNo}',
                                    style: TextStyle(
                                      color: const Color(0xFFEFEFEF),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  _buildRoleWidget(logic.userInfo.value.role),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     Image.asset(
                                  //       'assets/images/admin.png',
                                  //       width: 20.w,
                                  //       height: 20.w,
                                  //     ),
                                  //     2.horizontalSpace,
                                  //     Text(
                                  //       logic.userInfo.value.role,
                                  //       style: TextStyle(
                                  //         color: const Color(0xFFEFEFEF),
                                  //         fontSize: 17.sp,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/coin.png',
                              width: 24.w,
                              height: 24.w,
                            ),
                            2.horizontalSpace,
                            Text(
                              logic.userInfo.value.point.toString(),
                              style: TextStyle(
                                color: Styles.primaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/Location-Colorful.png',
                              width: 24.w,
                              height: 24.w,
                            ),
                            2.horizontalSpace,
                            Text(
                              logic.userInfo.value.city,
                              style: TextStyle(
                                color: Styles.primaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Container(
                width: 1.sw - 32.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Styles.commonBorder,
                  color: Colors.white,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PiMenuItem(
                      title: '账号与安全',
                      iconColor: Colors.redAccent,
                      icon: Icons.security_outlined,
                      onTap: logic.toAccountPage,
                    ),
                    PiMenuItem(
                      title: '典藏馆',
                      iconColor: Colors.lightBlueAccent,
                      icon: Icons.dataset,
                      onTap: logic.toCollectionPage,
                    ),
                    PiMenuItem(
                      title: '设置',
                      iconColor: Styles.primaryColor,
                      icon: Icons.settings,
                      onTap: logic.toSetUpPage,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleWidget(String role) {
    String src = '';
    switch (role) {
      case '管理员':
        src = 'assets/images/role_admin.png';
        break;
      case 'OP':
        src = 'assets/images/role_op.png';
        break;
      case '纪律委员':
        src = 'assets/images/role_manage.png';
        break;
      case '超级会员':
        src = 'assets/images/role_svip.png';
        break;
      case '成员':
        src = 'assets/images/role_user.png';
        break;
      case '新手':
        src = 'assets/images/role_new_user.png';
        break;
      default:
        src = 'assets/images/role_new_user.png';
        break;
    }
    return SizedBox(
      width: 80.w,
      height: 24.h,
      child: Image.asset(
        src,
        width: 80.w,
        height: 24.h,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
