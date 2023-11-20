import 'package:fishpi_app/router/app_router.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:fishpi_app/views/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'language/language.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 这里要加入开屏动画，等做好再加入
  await FpUtil.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String lang1 = FpUtil.getString('lang1',defValue: "zh");
    String lang2 = FpUtil.getString('lang2',defValue: "CN");
    return ScreenUtilInit(
      designSize: const Size(750,1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return GetMaterialApp(
          title: 'app_name'.tr,
          translations: Messages(),
          locale: Locale(lang1, lang2),
          debugShowCheckedModeBanner: false,//去掉debug图标
          fallbackLocale: const Locale('zh', 'CN'),// 在配置错误的情况下,使用的语言
          theme: ThemeData(
            brightness: Brightness.dark,
            hintColor: Colors.white,
            primaryColor: Colors.orange,
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.black,
            textTheme: TextTheme(
              bodyText1: TextStyle(decoration: TextDecoration.none),
            ),
          ),
          // 初始路径
          initialRoute: AppRouters.splash,
          // 404页面
          // unknownRoute: GetPage(name:'',page:()=>{}),
          getPages: AppRouters.getPages,
          home: const ChatPage(),
        );
      },
    );
  }
}
