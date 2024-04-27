import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 300.h,
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 200.w,
          height: 200.w,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80.w,
                  height: 80.w,
                ),
              ),
              10.verticalSpace,
              Text('加载中',style: TextStyle(fontSize: 16.sp,color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}
