import 'dart:math';
import 'package:fishpi_app/router/app_router.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'common_style/style.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  final transitionDuration = const Duration(seconds: 1);
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        // .then((value) => const Duration(seconds: 1))
        .then(
          (value) => Future.delayed(const Duration(seconds: 1)).then((value) {
            _lottieAnimation.forward().then((value) {
              // 检查是否登录，没有登录就去登录
              isLogin = FpUtil.getBool('isLogin');
              isLogin ? Get.offAllNamed(AppRouters.index) : Get.offAllNamed(AppRouters.login);
            });
          }),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: CommonStyle.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: _logoRemainder(),
              alignment: Alignment.center,
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(
          'assets/logo_lottie.json',
          onLoaded: (composition) {
            // _lottieAnimation.duration = composition.duration;
            _lottieAnimation.duration = const Duration(seconds: 2);
          },
          frameRate: FrameRate.max,
          fit: BoxFit.contain,
          repeat: true,
          animate: false,
          height: 160,
          width: 160,
          controller: _lottieAnimation,
        ),
        Image.asset(
          'assets/images/logo_word.png',
          width: 160,
        )
      ],
    );
  }
}
