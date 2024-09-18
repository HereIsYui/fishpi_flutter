import 'package:fishpi_app/pages/breezemoons/breezemoons_binding.dart';
import 'package:fishpi_app/pages/breezemoons/breezemoons_view.dart';
import 'package:fishpi_app/pages/chat/chat_binding.dart';
import 'package:fishpi_app/pages/chat/chat_view.dart';
import 'package:fishpi_app/pages/conversation/conversation_binding.dart';
import 'package:fishpi_app/pages/conversation/conversation_view.dart';
import 'package:fishpi_app/pages/forum/detail/forum_detail_binding.dart';
import 'package:fishpi_app/pages/forum/detail/forum_detail_view.dart';
import 'package:fishpi_app/pages/forum/forum_binding.dart';
import 'package:fishpi_app/pages/forum/forum_view.dart';
import 'package:fishpi_app/pages/home/home_binding.dart';
import 'package:fishpi_app/pages/home/home_view.dart';
import 'package:fishpi_app/pages/login/login_binding.dart';
import 'package:fishpi_app/pages/login/login_view.dart';
import 'package:fishpi_app/pages/mine/about/about_binding.dart';
import 'package:fishpi_app/pages/mine/about/about_view.dart';
import 'package:fishpi_app/pages/mine/edit_info/edit_info_binding.dart';
import 'package:fishpi_app/pages/mine/edit_info/edit_info_view.dart';
import 'package:fishpi_app/pages/mine/mine_binding.dart';
import 'package:fishpi_app/pages/mine/mine_view.dart';
import 'package:fishpi_app/pages/mine/set_up/set_up_binding.dart';
import 'package:fishpi_app/pages/mine/set_up/set_up_view.dart';
import 'package:fishpi_app/pages/splash/splash_binding.dart';
import 'package:fishpi_app/pages/splash/splash_view.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppPages {
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    Transition? transition,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: transition ?? Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    _pageBuilder(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    _pageBuilder(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    _pageBuilder(
      name: AppRoutes.conversation,
      page: () => ConversationPage(),
      binding: ConversationBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.chat,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.forum,
      page: () => ForumPage(),
      binding: ForumBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.forumDetail,
      page: () => ForumDetailPage(),
      binding: ForumDetailBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.breezemoons,
      page: () => BreezemoonsPage(),
      binding: BreezemoonsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.mine,
      page: () => MinePage(),
      binding: MineBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.editInfo,
      page: () => EditInfoPage(),
      binding: EditInfoBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.setUp,
      page: () => SetUpPage(),
      binding: SetUpBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.about,
      page: () => AboutPage(),
      binding: AboutBinding(),
    ),
  ];
}
