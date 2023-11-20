import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/chat.dart';

abstract class AppRouters {
  static const chat = '/chat';

  static final List<GetPage> getPages = [
    GetPage(name: chat, page: () => ChatPage())
  ];
}