import 'package:fishpi/types/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 自定义标签样式
const Map<String, TextStyle> _tagStyleMap = {
  "新人报道": TextStyle(color: Colors.red),
  "新人报到": TextStyle(color: Colors.red),
};

class Tag extends StatelessWidget {
  final ArticleTag tag;
  final double fontSize;
  final double iconSize;
  final void Function()? onTap;

  Tag(this.tag, { super.key, this.fontSize = 10, this.iconSize = 12, this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        print('点击了标签: ${tag.title}');
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        tag.iconPath.isNotEmpty
            ? Padding(
            padding: const EdgeInsets.only(top: 1, right: 1),
            child: Image.network(
              tag.iconPath,
              width: iconSize,
            ))
            : const Text(''),
        Padding(
          padding: const EdgeInsets.only(right: 4, left: 1),
          child: Text(
            tag.title,
            strutStyle: const StrutStyle(
              forceStrutHeight: true,
              leading: 0.5,
            ),
            style: TextStyle(color: Colors.grey, fontSize: fontSize)
                .merge(
                _tagStyleMap[tag.title] ?? const TextStyle()),
          ),
        )
      ]),
    );
  }
}
