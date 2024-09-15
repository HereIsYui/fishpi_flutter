part of 'pages.dart';

abstract class AppRoutes {
  static const notFound = '/not-found';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const conversation = '/conversation';
  static const chat = '/chat';
  static const forum = '/forum';
  static const breezemoons = '/breezemoons';
  static const mine = '/mine';
  static const editInfo = '/edit_info';
  static const setUp = '/set_up';
  static const about = '/about';
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
