import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastManager {
  static void show({String content = 'Loading'}) {
    EasyLoading.show(
        status: content,
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
  }

  static void showToast(String content) {
    EasyLoading.showToast(content);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
