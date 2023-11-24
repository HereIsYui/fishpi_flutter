import 'package:easy_refresh/easy_refresh.dart';
import 'package:fishpi_app/controller/breeze_controller.dart';
import 'package:fishpi_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with AutomaticKeepAliveClientMixin {
  final BreezeController breezeController = Get.put(BreezeController());
  late EasyRefreshController _controller;
  int page = 1;
  String token = "";

  @override
  void initState(){
    super.initState();
    token = FpUtil.getString('token');
    breezeController.init(token);
    _controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true
    );
    loadData();
  }

  void loadData(){
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
              //
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
              child: GetBuilder<BreezeController>(builder: (controller) {
                return breezeController.breezeList.isNotEmpty
                    ? const Text('还在写呢！！')
                    : const Text(
                  'is loading',
                  style: TextStyle(color: Colors.black),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
