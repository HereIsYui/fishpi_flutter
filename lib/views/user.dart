import 'package:fishpi_app/common_style/style.dart';
import 'package:fishpi_app/controller/user.dart';
import 'package:fishpi_app/utils/app_icon.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components/avatar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  final UserController userController = Get.put(UserController());
  String token = "";

  @override
  void initState() {
    super.initState();
    token = FpUtil.getString('token');
    userController.init(token);
    loadData();
  }

  void loadData() {
    userController.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<UserController>(builder: (controller) {
                return userController.user.oId.isNotEmpty
                    ? _userInfo()
                    : const Text(
                        'is loading',
                        style: TextStyle(color: Colors.black),
                      );
              }),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(
                    border: CommonStyle.commonBorder,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: _settingList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          border: CommonStyle.commonBorder,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // image: userController.user.cardBg.isNotEmpty
          //     ? DecorationImage(image: NetworkImage(userController.user.cardBg))
          //     : const DecorationImage(
          //         image: NetworkImage(
          //             'https://pwl.stackoverflow.wiki/2021/11/32ceecb7798ea1fa-82bd6ec7.jpg'),
          //         fit: BoxFit.cover,
          //         opacity: .4,
          //       ),
          color: Color.fromRGBO(0, 198, 174, 1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userController.user.nickname,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          userController.user.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      userController.user.intro,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '# ${userController.user.userNo}',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 17),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          userController.user.role,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Avatar(
                  size: 70.w,
                  image: userController.user.avatarURL,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: CommonStyle.primaryColor,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userController.user.point.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userController.user.city,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget _settingList() {
    return const Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.not_interested,
            color: Colors.red,
          ),
          title: Text(
            '屏蔽设置',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.analytics_outlined,
            color: Colors.orange,
          ),
          title: Text(
            '隐私政策',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
        ListTile(
          leading: Icon(
            FishIcon.notice,
            color: Colors.pinkAccent,
          ),
          title: Text(
            '消息通知',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.color_lens_outlined,
            color: Colors.greenAccent,
          ),
          title: Text(
            '外观设置',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text(
            '退出登录',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
