import 'package:get/get_navigation/src/routes/get_route.dart';

import '../splash_screen.dart';
import '../views/chat.dart';
import '../views/index.dart';

abstract class AppRouters {
  static const splash = '/splash';
  static const index = '/index';
  static const chat = '/chat';

  static final List<GetPage> getPages = [
    GetPage(name: index, page: () => const IndexPage()),
    GetPage(name: splash, page: () => const SplashScreenPage()),
    GetPage(name: chat, page: () => const ChatPage())
  ];
}