import 'package:animate_do/animate_do.dart';
import 'package:fishpi/types/chatroom.dart';
import 'package:fishpi/types/redpacket.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/utils/pi_utils.dart';
import 'package:fishpi_app/widgets/pi_avatar.dart';
import 'package:fishpi_app/widgets/pi_image.dart';
import 'package:fishpi_app/widgets/pi_input.dart';
import 'package:fishpi_app/widgets/pi_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:markdown_widget/widget/blocks/leaf/link.dart';

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
        body: Column(
          children: [
            Expanded(
              child: logic.messageList.isEmpty
                  ? Container()
                  : GestureDetector(
                      onTap: logic.closeAllTools,
                      child: Container(
                        width: 1.sw,
                        height: 1.sh,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: logic.isGroup.value
                            ? ListView.builder(
                                controller: logic.chatRoomController,
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                itemBuilder: _buildChatItem,
                                itemCount: logic.messageList.length,
                              )
                            : ListView.builder(
                                controller: logic.chatRoomController,
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                itemBuilder: _buildChatItem,
                                itemCount: logic.messageList.length,
                              ),
                      ),
                    ),
            ),
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2.w,
                    color: Styles.primaryTextColor,
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      // height: 35.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              logic.toggleVoice();
                            },
                            child: Container(
                              width: 24.w,
                              height: 24.w,
                              child: logic.isShowVoice.value
                                  ? Image.asset('assets/images/keyboard.png')
                                  : const Icon(
                                      Icons.keyboard_voice_outlined,
                                    ),
                            ),
                          ),
                          SizedBox(
                              width: 220.w,
                              child: logic.isShowVoice.value
                                  ? GestureDetector(
                                      onTap: () {},
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        width: 220.w,
                                        height: 34.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2.w,
                                            color: Styles.primaryTextColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '长按讲话',
                                          style: TextStyle(
                                            color: Styles.primaryTextColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 220.w,
                                      height: 34.h,
                                      child: PiInput(
                                        controller:
                                            logic.chatRoomControllerText,
                                        textAlign: logic.isShowVoice.value
                                            ? TextAlign.center
                                            : TextAlign.left,
                                        hintText: '说点什么...',
                                        focusNode: logic.chatRoomFocusNode,
                                        onInputChanged: (text) {
                                          logic.onInput(text);
                                        },
                                        onEditingComplete: () {
                                          logic.clickSend();
                                        },
                                      ),
                                    )),
                          GestureDetector(
                            onTap: () {
                              logic.toggleEmoji();
                            },
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: Image.asset(
                                'assets/images/face.png',
                                width: 24.w,
                                height: 24.w,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (logic.content.value == '') {
                                logic.toggleTools();
                              } else {
                                logic.clickSend();
                              }
                            },
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              alignment: Alignment.center,
                              child: Image.asset(
                                logic.content.value == ''
                                    ? 'assets/images/more_feature.png'
                                    : 'assets/images/send.png',
                                width: 28.w,
                                height: 28.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: logic.isShowEmoji.value,
                      child: FadeIn(
                        duration: const Duration(milliseconds: 200),
                        child: _buildEmojiBox(),
                      ),
                    ),
                    Visibility(
                      visible: logic.isShowTools.value,
                      child: FadeIn(
                        duration: const Duration(milliseconds: 200),
                        child: _buildToolsBox(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, int index) {
    ChatRoomMessage chat = logic.messageList[index];
    return GestureDetector(
      onTap: () {},
      child: chat.userName == logic.userInfo.value.userName
          ? _buildRight(chat)
          : _buildLeft(chat),
    );
  }

  Widget _buildRight(ChatRoomMessage chat) {
    return Container(
      width: 0.8.sw,
      margin: EdgeInsets.only(bottom: 5.h, top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.allName,
                  style: TextStyle(
                    color: Styles.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                chat.isRedpacket
                    ? _buildRedpacket(chat.redpacket!)
                    : (PiUtils.getChatPreview(chat).length == 1 &&
                            PiUtils.getChatPreview(chat).first is! Text)
                        ? Container(
                            width: 0.8.sw - 58.w,
                            padding: EdgeInsets.all(10.w),
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  PiUtils.getChatPreview(chat, isSelf: true),
                            ),
                          )
                        : Container(
                            width: 0.8.sw - 58.w,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.w),
                                bottomRight: Radius.circular(16.w),
                                bottomLeft: Radius.circular(16.w),
                              ),
                              border: Styles.commonBorder,
                              color: Styles.primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: PiUtils.getChatPreview(chat,isSelf: true),
                                ),
                                SizedBox(
                                  width: 0.8.sw - 58.w,
                                  child: Text(
                                    chat.time,
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
          ),
          10.horizontalSpace,
          PiAvatar(
            avatarURL: chat.avatarURL,
            userName: chat.userName,
            width: 48.w,
            height: 48.w,
          ),
        ],
      ),
    );
  }

  Widget _buildLeft(ChatRoomMessage chat) {
    return Container(
      width: 0.8.sw,
      margin: EdgeInsets.only(bottom: 5.h, top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              logic.clickUserAvatar(chat.userName);
            },
            child: PiAvatar(
              avatarURL: chat.avatarURL,
              userName: chat.userName,
              width: 48.w,
              height: 48.w,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.allName,
                  style: TextStyle(
                    color: Styles.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                chat.isRedpacket
                    ? _buildRedpacket(chat.redpacket!)
                    : (PiUtils.getChatPreview(chat).length == 1 &&
                            PiUtils.getChatPreview(chat).first is! Text)
                        ? Container(
                            width: 0.8.sw - 58.w,
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: PiUtils.getChatPreview(chat),
                            ),
                          )
                        : Container(
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
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: PiUtils.getChatPreview(chat),
                                ),
                                SizedBox(
                                  width: 0.8.sw - 58.w,
                                  child: Text(
                                    chat.time,
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
    );
  }

  Widget _buildEmojiBox() {
    return Container(
      width: 1.sw,
      height: 224.h,
      child: Column(
        children: [
          Container(
            height: 30.h,
            margin: EdgeInsets.symmetric(vertical: 5.h),
            alignment: Alignment.center,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    logic.emojiIndex.value = 0;
                  },
                  child: AnimatedOpacity(
                    opacity: logic.emojiIndex.value == 0 ? 1 : 0.3,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Image.asset(
                        'assets/images/face.png',
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logic.emojiIndex.value = 1;
                  },
                  child: AnimatedOpacity(
                    opacity: logic.emojiIndex.value == 1 ? 1 : 0.3,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        Icons.photo,
                        size: 30.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 1.sw,
              child: [
                _buildDefaultEmojiBox(),
                _buildDiyEmojiBox()
              ][logic.emojiIndex.value],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultEmojiBox() {
    List<Widget> list = [];
    logic.emojiList.forEach((key, value) {
      list.add(
        GestureDetector(
          onTap: () {
            logic.chatRoomControllerText.text = ':$key:';
            logic.onInput(':$key:');
            logic.clickSend();
          },
          child: Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            child: PiImage(
              imgUrl: value,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
      );
    });
    // 返回一个GridView
    return GridView.count(
      crossAxisCount: 8,
      scrollDirection: Axis.vertical,
      //设置横向间距
      crossAxisSpacing: 4.w,
      //设置主轴间距
      mainAxisSpacing: 4.w,
      children: list,
    );
  }

  Widget _buildDiyEmojiBox() {
    List<Widget> list = [];
    for (var item in logic.diyEmojiList) {
      list.add(
        GestureDetector(
          onTap: () {
            logic.chatRoomControllerText.text = '![图片表情]($item)';
            logic.onInput('![图片表情]($item)');
            logic.clickSend();
          },
          child: Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            child: PiImage(
              imgUrl: item,
              width: 80.w,
              height: 80.w,
            ),
          ),
        ),
      );
    }
    return GridView.count(
      crossAxisCount: 4,
      scrollDirection: Axis.vertical,
      //设置横向间距
      crossAxisSpacing: 4.w,
      //设置主轴间距
      mainAxisSpacing: 4.w,
      children: list,
    );
  }

  Widget _buildToolsBox() {
    List<Widget> list = [
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 80.w,
          height: 80.w,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.photo,
                  size: 30.w,
                ),
              ),
              5.verticalSpace,
              Text(
                '图片',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Styles.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 80.w,
          height: 80.w,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.camera_alt,
                  size: 30.w,
                ),
              ),
              5.verticalSpace,
              Text(
                '拍摄',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Styles.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 80.w,
          height: 80.w,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_bag,
                  size: 30.w,
                ),
              ),
              5.verticalSpace,
              Text(
                '红包',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Styles.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    return Container(
      width: 1.sw,
      height: 224.h,
      padding: EdgeInsets.all(10.w),
      color: const Color(0xFFF5F7F9),
      child: GridView.count(
        crossAxisCount: 4,
        scrollDirection: Axis.vertical,
        //设置横向间距
        crossAxisSpacing: 4.w,
        //设置主轴间距
        mainAxisSpacing: 4.w,
        children: list,
      ),
    );
  }

  Widget _buildRedpacket(RedPacketMessage redpacket) {
    return Container(
      width: 0.8.sw - 58.w,
      alignment: Alignment.centerLeft,
      child: Container(
        width: 210.w,
        height: 88.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9900),
          borderRadius: BorderRadius.circular(8.w),
          border: Styles.redpacketBorder,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/redpack_icon.png',
                  width: 30.w,
                  height: 30.h,
                ),
                5.horizontalSpace,
                Expanded(
                  child: Text(
                    redpacket.msg,
                    style: TextStyle(fontSize: 21.sp, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Container(
              height: 2.h,
              margin: EdgeInsets.symmetric(vertical: 5.h),
              color: const Color(0xFFF95A2C),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${RedPacketType.toName(redpacket.type)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFF0D35E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/coin_line_white.png',
                      width: 14.w,
                      height: 10.w,
                    ),
                    5.horizontalSpace,
                    Text(
                      '${redpacket.money}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFFF0D35E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
