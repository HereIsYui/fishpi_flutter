import 'package:fishpi_app/controller/login_controller.dart';
import 'package:fishpi_app/router/app_router.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

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
            color: const Color.fromRGBO(236, 212, 99, 1),
            padding: const EdgeInsets.all(10),
            child: Center(
                child: SizedBox(
              width: 327.w,
              height: 370.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login title'.tr,
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
                        FpUtil.showToast('请输入用户名');
                        return;
                      }
                      if (pwd.isEmpty) {
                        FpUtil.showToast('请输入密码');
                        return;
                      }
                      var cb = await loginController.login(userName, pwd);
                      switch (cb.code) {
                        case 0:
                          Get.offNamed(AppRouters.index);
                          break;
                        case 1:
                          // 二步验证弹窗
                          _showMfaCodeDialog();
                          FpUtil.showToast(cb.msg);
                          break;
                        case 2:
                          FpUtil.showToast(cb.msg);
                          break;
                        default:
                          break;
                      }
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
                        '登录',
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
                            '还没有账号？',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('点击了注册');
                            },
                            child: Text(
                              '立即注册',
                              style: TextStyle(
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
  void _onUserNameChanged(value) async {
    userName = value;
  }

  /// 密码输入框输入
  void _onPwdChanged(value) async {
    pwd = value;
  }

  /// 二步验证弹窗
  void _showMfaCodeDialog() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(.5),
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
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  /// 二步验证组件 有bug 下次改
                  // PinInputTextField(
                  //   pinLength: 6,
                  //   controller: _pinEditingController,
                  //   autoFocus: true,
                  //   onChanged: _onPinChange,
                  //   keyboardType: TextInputType.number,
                  //   decoration: UnderlineDecoration(
                  //     textStyle: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 20.sp,
                  //     ),
                  //     colorBuilder:
                  //         PinListenColorBuilder(Colors.black, Colors.grey),
                  //     bgColorBuilder: null,
                  //   ),
                  // ),
                  Container(
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
                          decoration: TextDecoration.none),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  /// 二步验证输入
  void _onPinChange(value) async {
    mfaCode = value;
  }
}
