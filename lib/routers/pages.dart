import 'package:fishpi_app/pages/login/login_binding.dart';
import 'package:fishpi_app/pages/login/login_view.dart';
import 'package:fishpi_app/pages/splash/splash_binding.dart';
import 'package:fishpi_app/pages/splash/splash_view.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppPages {
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
