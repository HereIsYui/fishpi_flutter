import 'package:get/get.dart';
import 'zh_cn/lang.dart' as zh_cn;

class Messages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'zh_cn': zh_cn.lang,
  };
}