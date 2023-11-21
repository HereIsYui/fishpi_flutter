import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: const Color.fromRGBO(236, 212, 99, 1),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Login title'.tr,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
