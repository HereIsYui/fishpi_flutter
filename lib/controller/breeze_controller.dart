import 'package:fishpi/fishpi.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BreezeController extends GetxController {
  late Fishpi fishpi;
  List<BreezemoonContent> breezeList = [];

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getBreezeList(int page) async {
    List<BreezemoonContent> list = await fishpi.breezemoon.list(page: page);
    print(list.toString());
    if (page == 1) {
      breezeList = list;
    } else {
      breezeList += list;
    }
    update();
  }

  Future<void> sendBreeze(String content) async {
    EasyLoading.show(status: 'loading...');
    await fishpi.breezemoon.send(content);
    EasyLoading.dismiss();
    return;
  }
}
