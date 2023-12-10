import 'package:fishpi/fishpi.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late Fishpi fishpi;
  List<ChatData> chatList = [];
  List<ChatRoomMessage> chatRoomMsg = [];
  String chatLastMsg = "";
  String chatLastUser = "";

  Future<void> init(String token) async {
    fishpi = Fishpi(token);
  }

  Future<void> getChatList() async {
    chatList = await fishpi.chat.list();
    print(chatList.toString());
    update();
  }

  Future<void> getChatRoomHistory() async{
    List<ChatRoomMessage> historyMsg = await fishpi.chatroom.more(1);
    chatRoomMsg.addAll(historyMsg);
  }

  ///  连接聊天室
  Future<void> chetInit() async {
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
            chatRoomMsg.add(data.msg!);
            chatLastMsg = data.msg!.content;
            chatLastUser = data.msg!.userName;
            if(chatRoomMsg.length > 200){
              // chatRoomMsg
            }
            update();
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
