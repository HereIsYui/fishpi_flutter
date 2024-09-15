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

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<List<ChatData>> getChatList() async {
    List<ChatData> list = await fishpi.chat.list();
    return list;
  }

  Future<void> chatInit() async {
    fishpi.chatroom.addListener((ChatRoomData data) {
      try {
        switch (data.type) {
          case ChatRoomMessageType.online:
            // 上线消息
            print(data.online!);
            break;
          case ChatRoomMessageType.barrager:
            // 弹幕消息
            print(data.barrager!);
            break;
          case ChatRoomMessageType.discussChanged:
            // 话题变更
            print(data.discuss!);
            break;
          case ChatRoomMessageType.msg:
            // 普通消息
            print(data.msg!.content);
            break;
          case ChatRoomMessageType.revoke:
            // 撤回消息
            print(data.revoke!);
            break;
          case ChatRoomMessageType.redPacket:
            // 红包消息
            print(data.msg!);
            break;
          case ChatRoomMessageType.redPacketStatus:
            // 红包领取
            print(data.status!);
            break;
          case ChatRoomMessageType.custom:
            // 自定义消息
            print(data.custom!);
            break;
        }
      } catch (e) {
        print('未知异常：$e');
      }
    });
  }
}
