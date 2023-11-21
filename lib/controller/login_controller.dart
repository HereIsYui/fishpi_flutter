import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Fishpi fishpi = Fishpi();
  String token =
      'c97d3321a064f0670886d615cac51636bdf4567c0e25a5bc6eba032a511ca8691fc4d3452b78bebaa6c62e3fedb6da5593f4e775e04ec5a6ed96c764b22a6929a94a57bc80e2dbbdb0403a4208898c7899c91bf3d42c099c7b73a74c1b6b0687';

  Future<String> login(String userName, String pwd, {String mfaCode = "", void Function()? mfaCb}) async {
    LoginData loginData =
          LoginData(username: userName, passwd: pwd, mfaCode: mfaCode);
      return fishpi.login(loginData).onError((e, stackTrace) {
        if(e.toString() == '两步验证失败，请填写正确的一次性密码' && mfaCb != null && mfaCode.isEmpty) {
          mfaCb();
          e = '请输入二次验证码';
        }
        return Future.error(e!);
      });
  }
}