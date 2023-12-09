import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FpUtil {
  static SharedPreferences? _prefs;

  static FpUtil? _instance;

  static Future<FpUtil?> getInstance() async {
    _instance ??= await FpUtil._()._init();

    return _instance;
  }

  FpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs?.getString(key) ?? defValue;
  }

  static Future<bool>? setString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs?.setString(key, value);
  }

  static bool getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs?.getBool(key) ?? defValue;
  }

  static Future<bool>? setBool(String key, bool value) {
    if (_prefs == null) return null;
    return _prefs?.setBool(key, value);
  }

  static int getInt(String key, {int defValue = 0}) {
    if (_prefs == null) return defValue;
    return _prefs?.getInt(key) ?? defValue;
  }

  static Future<bool>? setInt(String key, int value) {
    if (_prefs == null) return null;
    return _prefs?.setInt(key, value);
  }

  static double getDouble(String key, {double defValue = 0.0}) {
    if (_prefs == null) return defValue;
    return _prefs?.getDouble(key) ?? defValue;
  }

  static Future<bool>? setDouble(String key, double value) {
    if (_prefs == null) return null;
    return _prefs?.setDouble(key, value);
  }

  static Future<bool>? remove(String key) {
    if (_prefs == null) return null;
    return _prefs?.remove(key);
  }

  static Future<bool>? clear() {
    if (_prefs == null) return null;
    return _prefs?.clear();
  }

  static Future<void> showToast(String msg) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  /// 聊天时间处理
  /// [time] 发消息时间
  /// 5分钟以内返回:刚刚 一天内的返回:具体时间 前一天的返回:昨天 其他的返回:日期
  static getChatTime(String time) {
    var chatTime = DateTime.parse(time);
    var nowTime = DateTime.now();
    var interval = nowTime.millisecondsSinceEpoch - chatTime.millisecondsSinceEpoch;
    var cb = '${chatTime.month}月${chatTime.day}日';
    if(interval < 5 * 60 * 1000){
      cb = '刚刚';
    }else if (interval < 24 * 60 * 60 * 1000){
      cb = '${chatTime.hour}:${chatTime.minute}';
    }else if (interval < 48 * 60 * 60 * 1000){
      cb = '昨天';
    }else{
      cb = '${chatTime.month}月${chatTime.day}日';
    }
    return cb;
  }
}
