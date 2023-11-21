import 'package:fishpi_app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController userNameController;
  late TextEditingController pwdController;
  final PostController postController = Get.put(PostController());
  String userName = "";
  String pwd = "";
  String twoKey = "";

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
                    onTap: (){
                      print('点击了登录');
                    },
                    child: Container(
                      width: 327.w,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: const Text('登录',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
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
                          Text('还没有账号？',style: TextStyle(color:Colors.black,fontSize: 10.0,fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: (){
                              print('点击了注册');
                            },
                            child: Text('立即注册',style: TextStyle(color: Colors.red,fontSize: 10.0,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          print('点击了扫码登录');
                        },
                        child: const Icon(Icons.qr_code_scanner,color: Colors.black,size: 20,),
                      )
                    ],
                  )
                ],
              ),
            )
          )
        ),
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
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
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
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
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
  void _onPwdChanged(value) async{
    pwd = value;
  }
}
