import 'package:fishpi_app/res/icons.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PiBottomBar extends StatelessWidget {
  final Function(int) callback;
  final int index;

  const PiBottomBar({
    required this.callback,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(
            color: Styles.primaryTextColor,
            width: 2,
          ),
        ),
        color: Styles.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem(
            icon: const Icon(FishIcon.chat),
            title: '聊天',
            idx: 0,
            cb: callback,
          ),
          _buildItem(
            icon: const Icon(FishIcon.article),
            title: '帖子',
            idx: 1,
            cb: callback,
          ),
          _buildItem(
            icon: const Icon(FishIcon.breeze),
            title: '清风明月',
            idx: 2,
            cb: callback,
          ),
          _buildItem(
            icon: const Icon(FishIcon.my),
            title: '我的',
            idx: 3,
            cb: callback,
          )
        ],
      ),
    );
  }

  Widget _buildItem({
    required Icon icon,
    required String title,
    required int idx,
    required Function(int) cb,
  }) {
    return GestureDetector(
      onTap: () => cb(idx),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: (1.sw - 32.w) / 4,
        child: Opacity(
          opacity: index == idx ? 1 : 0.7,
          child: Column(
            children: [
              icon,
              5.verticalSpace,
              Text(
                title,
                style: Styles.bottomTextStyle,
              ),
              Icon(
                Icons.arrow_drop_up_outlined,
                color:
                    index == idx ? Styles.primaryTextColor : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
