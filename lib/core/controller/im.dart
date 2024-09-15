import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class IMController extends GetxController {
  Fishpi fishpi = Fishpi();

  Future<String> login(
    LoginData loginData, {
    String mfaCode = '',
    void Function()? mfaCb,
  }) {
    return fishpi.login(loginData).onError((e, stackTrace) {
      if (e.toString() == '两步验证失败，请填写正确的一次性密码' &&
          mfaCb != null &&
          mfaCode.isEmpty) {
        mfaCb();
        e = '请输入正确的二次验证码';
      }
      return Future.error(e!);
    });
  }
}
