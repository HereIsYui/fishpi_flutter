import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

import '../im_callback.dart';

class IMController extends GetxController with IMCallback{
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
            recvOnlineMessage(data.online!);
            break;
          case ChatRoomMessageType.barrager:
            recvBarrageMessage(data.barrager!);
            break;
          case ChatRoomMessageType.discussChanged:
            recvDiscussMessage(data.discuss!);
            break;
          case ChatRoomMessageType.msg:
            recvNewMessage(data.msg!);
            break;
          case ChatRoomMessageType.revoke:
            recvRevokeMessage(data.revoke!);
            break;
          case ChatRoomMessageType.redPacket:
            recvRedPacketMessage(data.msg!);
            break;
          case ChatRoomMessageType.redPacketStatus:
            recvRedPacketStatusMessage(data.status!);
            break;
          case ChatRoomMessageType.custom:
            recvCustomMessage(data.custom!);
            break;
        }
      } catch (e) {
        print('未知异常：$e');
      }
    });
  }

}
