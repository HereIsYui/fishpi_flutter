import 'package:fishpi_app/views/breezemoon.dart';
import 'package:fishpi_app/views/login.dart';
import 'package:fishpi_app/views/article.dart';
import 'package:fishpi_app/views/user.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../splash_screen.dart';
import '../views/chat.dart';
import '../views/chatroom.dart';
import '../views/index.dart';

abstract class AppRouters {
  static const splash = '/splash';
  static const index = '/index';
  static const chat = '/chat';
  static const article = '/article';
  static const breezemoon = '/circle';
  static const user = '/user';
  static const login = '/login';
  static const chatroom = '/chatroom';

  static final List<GetPage> getPages = [
    GetPage(name: index, page: () => const IndexPage()),
    GetPage(name: splash, page: () => const SplashScreenPage()),
    GetPage(name: chat, page: () => const ChatPage()),
    GetPage(name: article, page: ()=> const ArticlePage()),
    GetPage(name: breezemoon, page: ()=> const BreezeMoonPage()),
    GetPage(name: user, page: ()=> const UserPage()),
    GetPage(name: login, page: ()=> const LoginPage()),
    GetPage(name: chatroom, page: ()=> const ChatRoomPage()),

  ];
}