import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi_app/common_style/style.dart';
import 'package:fishpi_app/controller/breezemoon.dart';
import 'package:fishpi_app/utils/app_icon.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../components/avatar.dart';

class BreezeMoonPage extends StatefulWidget {
  const BreezeMoonPage({super.key});

  @override
  State<BreezeMoonPage> createState() => _BreezeMoonPageState();
}

class _BreezeMoonPageState extends State<BreezeMoonPage>
    with AutomaticKeepAliveClientMixin {
  final BreezeMoonController breezeController = Get.put(BreezeMoonController());
  late EasyRefreshController _controller;
  late TextEditingController breezeSendController;
  String breezeContent = "";
  int page = 1;
  String token = "";

  @override
  void initState() {
    super.initState();
    token = FpUtil.getString('token');
    breezeController.init(token);
    _controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    breezeSendController = TextEditingController();
    loadData();
  }

  void loadData() {
    breezeController.getBreezeList(page);
    page == 1 ? _controller.finishRefresh() : _controller.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: EasyRefresh.builder(
          controller: _controller,
          header: ClassicHeader(
            dragText: 'Pull to refresh'.tr,
            armedText: 'Release ready'.tr,
            readyText: 'Refreshing...'.tr,
            processingText: 'Refreshing...'.tr,
            processedText: 'Succeeded'.tr,
            noMoreText: 'No more'.tr,
            failedText: 'Failed'.tr,
            messageText: 'Last updated at %T'.tr,
            safeArea: false,
            textStyle: const TextStyle(color: Colors.grey),
          ),
          footer: ClassicFooter(
            position: IndicatorPosition.behind,
            textStyle: const TextStyle(color: Colors.grey),
            dragText: 'Pull to load'.tr,
            armedText: 'Release ready'.tr,
            readyText: 'Loading...'.tr,
            processingText: 'Loading...'.tr,
            processedText: 'Succeeded'.tr,
            noMoreText: 'No more'.tr,
            failedText: 'Failed'.tr,
            messageText: 'Last updated at %T'.tr,
            // infiniteOffset: null,
          ),
          onRefresh: () async {
            page = 1;
            loadData();
          },
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 0), () {
              print('已到达世界边缘');
              page++;
              loadData();

              /// 等等？清风明月好像没返回一共有多少页？
              // if (breezeController.breezeList.length < 5) {
              //   page++;
              //   loadData();
              // } else {
              //   _controller.finishLoad(IndicatorResult.noMore);
              // }
            });
          },
          childBuilder: (BuildContext context, ScrollPhysics physics) {
            return Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.white,
                child: GetBuilder<BreezeMoonController>(builder: (controller) {
                  return breezeController.breezeList.isNotEmpty
                      ? _breezeList(physics)
                      : const Text(
                          'is loading',
                          style: TextStyle(color: Colors.black),
                        );
                }));
          },
        ),
      ),
    );
  }

  Widget _breezeList(physics) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: physics,
      itemCount: breezeController.breezeList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return buildBreezeInputWidget(breezeSendController);
        } else {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: const BoxDecoration(
              border: CommonStyle.commonBorder,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Avatar(
                          size: 35.w,
                          image: breezeController.breezeList[index].thumbnailURL48,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          breezeController.breezeList[index].authorName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Text(
                      breezeController.breezeList[index].timeAgo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                handleBreeze(breezeController.breezeList[index].content),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 12,
                    ),
                    Text(
                      breezeController.breezeList[index].city.isNotEmpty
                          ? breezeController.breezeList[index].city
                          : '未知',
                      style: const TextStyle(color: Colors.black, fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }

  /// 清风明月输入框
  Widget buildBreezeInputWidget(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 340.w,
            height: 36.h,
            child: TextField(
              controller: controller,
              cursorColor: Colors.black,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
              decoration: const InputDecoration(
                hintText: "随便说说...",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              keyboardType: TextInputType.text,
              onChanged: _breezeChange,
            ),
          ),
          GestureDetector(
            onTap: () {
              breezeController.sendBreeze(breezeContent).then((value) {
                breezeSendController.clear();
                page = 1;
                loadData();
              });
            },
            child: Icon(
              FishIcon.send,
              color: Colors.black,
              size: 30.h,
            ),
          )
        ],
      ),
    );
  }

  void _breezeChange(value) {
    breezeContent = value;
  }

  /// 清风明月内容处理
  Widget handleBreeze(content) {
    var document = parse(content);
    List<Widget> list = [];

    /// 处理文本
    document.querySelectorAll("p,h1,h2,h3,h4,h5,h6,h7").forEach((element) {
      if (element.text.isEmpty) return;
      list.add(
        Text(
          element.text,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
        ),
      );
    });

    /// 处理图片
    document.querySelectorAll("img").forEach((element) {
      if (element.attributes['src']!.isEmpty) return;
      list.add(
        Image.network(element.attributes['src']!),
      );
    });
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        children: list,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
