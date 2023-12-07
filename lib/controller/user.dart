import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late Fishpi fishpi;
  UserInfo user = UserInfo();

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getUserList() async {
    user = await fishpi.user.info();
    print(user.toJson());
    update();
  }
}
