import 'package:fishpi_app/res/styles.dart';
import 'package:fishpi_app/widgets/loading.dart';
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
          child: logic.isLoading.value
              ? const Loading()
              : ListView(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  children: [
                    Text(
                      logic.article.value.titleEmojUnicode,
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${logic.article.value.authorName}·${logic.article.value.timeAgo}·${logic.article.value.viewCnt}人看过',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9FA4B4),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Divider(),
                    ...buildMarkdown(),
                    Container(
                      child:
                      logic.article.value.rewarded ?
                      Column(
                        children: [
                          Text(logic.article.value.rewardContent)
                        ],
                      ):Column(
                        children: [
                          Text('打赏${logic.article.value.rewardPoint}积分可见')
                        ],
                      ),
                    )
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
            onTap: (url) {},
          )
        ],
      ),
    );
  }
}
