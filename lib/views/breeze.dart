import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Circle list'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
