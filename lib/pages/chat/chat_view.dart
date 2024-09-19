import 'package:fishpi/types/chatroom.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:fishpi_app/widgets/pi_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  final ChatLogic logic = Get.put(ChatLogic());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PiTitleBar.back(
          title: logic.isGroup.value ? '聊天室' : logic.userName.value,
        ),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: logic.isGroup.value
              ? ListView.builder(
                  controller: logic.chatRoomController,
                  itemBuilder: _buildChatItem,
                  itemCount: logic.messageList.length,
                )
              : ListView.builder(
                  controller: logic.chatRoomController,
                  itemBuilder: _buildChatItem,
                  itemCount: logic.messageList.length,
                ),
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, int index) {
    ChatRoomMessage chat = logic.messageList[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 0.8.sw,
        margin: EdgeInsets.only(bottom: 5.h,top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PiAvatar(
              avatarURL: chat.avatarURL,
              userName: chat.userName,
              width: 48.w,
              height: 48.w,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.userName,
                    style: TextStyle(
                      color: Styles.primaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    width: 0.8.sw - 58.w,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.w),
                        bottomRight: Radius.circular(16.w),
                        bottomLeft: Radius.circular(16.w),
                      ),
                      border: Styles.commonBorder,
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PiUtils.getChatPreview(chat.content),
                        ),
                        SizedBox(
                          width: 0.8.sw - 58.w,
                          child: Text(
                            chat.time.split(' ')[1],
                            style: TextStyle(
                              color: const Color(0xFF9FA4B4),
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
