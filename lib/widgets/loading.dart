import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 1.sw,
      height: .5.sh,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "assets/logo_lottie.json",
              width: 100.w,
              height: 100.w,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16.sp,
                color: Styles.primaryTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
