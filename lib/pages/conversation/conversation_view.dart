import 'package:fishpi/types/chat.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/routers/navigator.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/pi_dashed.dart';
import 'conversation_logic.dart';

class ConversationPage extends StatelessWidget {
  final ConversationLogic logic = Get.put(ConversationLogic());

  ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: ListView.builder(
          itemCount: logic.chatList.length + 1,
          itemBuilder: (_, index) => _buildConversation(_, index),
        ),
      ),
    );
  }

  Widget _buildConversation(
    BuildContext context,
    int index,
  ) {
    if (index == 0) {
      return _buildItem();
    }
    ChatData chat = logic.chatList[index - 1];
    return _buildItem(chat: chat);
  }

  Widget _buildItem({
    ChatData? chat,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        AppNavigator.toChat(
          isGroup: chat == null,
          userID: chat?.fromId,
          userName: chat?.receiverUserName ?? '聊天室',
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                chat != null
                    ? PiAvatar(
                        userName: chat.receiverUserName,
                        avatarURL: chat.receiverAvatar,
                        width: 48.w,
                        height: 48.w,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48.w),
                          border: Border.all(
                            width: 2.w,
                            color: Styles.primaryTextColor,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(48.w),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                        ),
                      ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              chat != null ? chat.receiverUserName : '聊天室',
                              style: TextStyle(
                                fontSize: 21.sp,
                                color: Styles.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            PiUtils.getChatTime(
                              chat != null
                                  ? chat.time
                                  : '${logic.messageList.lastOrNull?.time}',
                            ),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF9FA4B4),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Text(
                        chat != null
                            ? chat.preview
                            : '${logic.messageList.lastOrNull?.userName}:${PiUtils.getChatPreview(logic.messageList.lastOrNull?.content ?? '')}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Styles.secondaryTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PiDashed(
            dashedWidth: 2.w,
            color: Styles.c4Color,
          ),
        ],
      ),
    );
  }
}
