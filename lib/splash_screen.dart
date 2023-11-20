import 'dart:math';
import 'package:fishpi_app/router/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _IntroPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  final transitionDuration = const Duration(seconds: 1);

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
          (value) => Future.delayed(const Duration(seconds: 1)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => {
                    Get.toNamed(AppRouters.chat)
                  },
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(236, 212, 99, 1),
              Color.fromRGBO(236, 212, 99, 1),
            ],
          ),
        ),
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
        Image.asset('assets/images/logo_word.png',width: 160,)
      ],
    );
  }
}}
