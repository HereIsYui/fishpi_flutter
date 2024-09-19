import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/widgets/pi_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'forum_detail_logic.dart';

class ForumDetailPage extends StatelessWidget {
  final ForumDetailLogic logic = Get.put(ForumDetailLogic());

  ForumDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PiTitleBar.back(
        title: '详情',
      ),
      body: Obx(
        () => SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            children: [
              Text(
                logic.article.value.titleEmojUnicode,
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              ...buildMarkdown(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildMarkdown() {
    String article = logic.article.value.source;
    var parser = EmojiParser();
    article = parser.emojify(article);
    return MarkdownGenerator().buildWidgets(
      article,
      config: MarkdownConfig(
        configs: [

          LinkConfig(
            style: const TextStyle(
              color: Styles.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: Styles.primaryColor,
            ),
            onTap: (url) {

            },
          )
        ],
      ),
    );
  }
}
