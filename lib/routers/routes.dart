part of 'pages.dart';

abstract class AppRoutes {
  static const notFound = '/not-found';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}