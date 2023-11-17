import 'package:fishpi_app/router/appRouter.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:fishpi_app/views/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'language/language.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750,1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return GetMaterialApp(
          title: 'app_name'.tr,
          translations: Messages(),
          debugShowCheckedModeBanner: false,//去掉debug图标
          fallbackLocale: const Locale('zh', 'CN'),// 在配置错误的情况下,使用的语言

          // 初始路径
          initialRoute: AppRouters.chat,
          // 404页面
          // unknownRoute: GetPage(name:'',page:()=>{}),
          getPages: AppRouters.getPages,
          home: ChatPage(),
        );
      },
    );
  }
}
