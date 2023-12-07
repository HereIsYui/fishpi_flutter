import 'package:fishpi/types/types.dart';
import 'package:fishpi_app/controller/login.dart';
import 'package:fishpi_app/router/app_router.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../common_style/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController userNameController;
  late TextEditingController pwdController;
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController _pinEditingController =
      TextEditingController(text: '');
  String userName = "";
  String pwd = "";
  String mfaCode = "";

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    pwdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            width: 1.sw,
            height: 1.sh,
            color: CommonStyle.primaryColor,
            padding: const EdgeInsets.all(10),
            child: Center(
                child: SizedBox(
              width: 327.w,
              height: 370.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'login.title'.tr,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  buildUserNameInputWidget(userNameController),
                  SizedBox(
                    height: 24.h,
                  ),
                  buildPwdInputWidget(pwdController),
                  SizedBox(
                    height: 48.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('点击了登录');
                      if (userName.isEmpty) {
                        FpUtil.showToast('login.username_placeholder'.tr);
                        return;
                      }
                      if (pwd.isEmpty) {
                        FpUtil.showToast('login.password_placeholder'.tr);
                        return;
                      }
                      _pinEditingController.clear();
                      loginController.login(userName, pwd, mfaCb: () {
                        _showMfaCodeDialog();
                      }).then((token) {
                        EasyLoading.dismiss();
                        FpUtil.setString('token', token);
                        FpUtil.setBool('isLogin', true);
                        Get.offNamed(AppRouters.index);
                      }).catchError((e) {
                        EasyLoading.dismiss();
                        FpUtil.showToast(e.toString());
                      });
                    },
                    child: Container(
                      width: 327.w,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: const Text(
                        'login.title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'login.no_account_yet'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('点击了注册');
                            },
                            child: Text(
                              'login.register_now'.tr,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print('点击了扫码登录');
                        },
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.black,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))),
      ),
    );
  }

  /// 用户名输入框
  Widget buildUserNameInputWidget(TextEditingController controller) {
    return SizedBox(
      width: 327.w,
      height: 56.h,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        decoration: const InputDecoration(
          hintText: "用户名",
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(0, 0, 50, 0),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.person),
          prefixIconColor: Colors.black,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        keyboardType: TextInputType.text,
        onChanged: _onUserNameChanged,
      ),
    );
  }

  /// 密码输入框
  Widget buildPwdInputWidget(TextEditingController controller) {
    return SizedBox(
      width: 327.w,
      height: 56.h,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        decoration: const InputDecoration(
          hintText: "密码",
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(0, 0, 50, 0),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.lock),
          prefixIconColor: Colors.black,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: _onPwdChanged,
      ),
    );
  }

  /// 用户名输入框输入
  void _onUserNameChanged(value) {
    userName = value;
  }

  /// 密码输入框输入
  void _onPwdChanged(value) {
    pwd = value;
  }

  /// 二步验证弹窗
  void _showMfaCodeDialog() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(.1),
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return ScaleTransition(scale: animation, child: child);
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: Container(
              width: 392.w,
              height: 220.h,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 244, 204, 1),
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  // 二步验证组件 有bug 下次改
                  Material(
                      color: const Color.fromRGBO(255, 244, 204, 1),
                      child: Container(
                        height: 48.h,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: PinInputTextField(
                          pinLength: 6,
                          controller: _pinEditingController,
                          autoFocus: true,
                          onChanged: _onPinChange,
                          keyboardType: TextInputType.number,
                          decoration: BoxLooseDecoration(
                            strokeWidth: 2,
                            radius: const Radius.circular(10),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                            ),
                            strokeColorBuilder: PinListenColorBuilder(
                                Colors.black, Colors.grey),
                            bgColorBuilder: PinListenColorBuilder(
                              const Color.fromRGBO(255, 255, 255, 1),
                              const Color.fromRGBO(255, 244, 204, 1),
                            ),
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      print('点击提交二次验证码');
                      Navigator.pop(context);
                      _pinEditingController.clear();
                      loginController.login(userName, pwd,mfaCode: mfaCode, mfaCb: () {
                        _showMfaCodeDialog();
                      }).then((token) {
                        EasyLoading.dismiss();
                        FpUtil.setString('token', token);
                        FpUtil.setBool('isLogin', true);
                        Get.offNamed(AppRouters.index);
                      }).catchError((e) {
                        EasyLoading.dismiss();
                        FpUtil.showToast(e.toString());
                      });
                    },
                    child: Container(
                      width: 290.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: const Text(
                        "提交二次验证码",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  /// 二步验证输入
  void _onPinChange(value) {
    mfaCode = value;
  }
}
