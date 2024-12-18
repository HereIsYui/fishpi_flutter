import 'package:hive/hive.dart';

class BlackList {
  static late Box msgBox;

  static Future<void> init() async {
    msgBox = await Hive.openBox('blackList');
  }

  static get blackList => msgBox.values.toList().reversed.toList();

  static removeUser(int index) async {
    return await msgBox.delete(index);
  }

  static dispose() {
    msgBox.close();
  }
}
