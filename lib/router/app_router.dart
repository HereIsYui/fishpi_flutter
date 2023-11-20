import 'package:get/get_navigation/src/routes/get_route.dart';

import '../splash_screen.dart';
import '../views/chat.dart';

abstract class AppRouters {
  static const chat = '/chat';
  static const splash = '/splash';

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashScreenPage()),
    GetPage(name: chat, page: () => const ChatPage())
  ];
}