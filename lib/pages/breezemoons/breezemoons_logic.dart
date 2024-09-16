import 'package:fishpi/types/breezemoon.dart';
import 'package:fishpi_app/core/controller/im.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class BreezemoonsLogic extends GetxController {
  final refresherController = RefreshController();
  final imController = Get.find<IMController>();

  final list = <BreezemoonContent>[].obs;
  final page = 0.obs;
  final isFinished = false.obs;
  @override
  void onInit(){
    
    super.onInit();
  }

  void initBreezemoon() async{
    List<BreezemoonContent> res = await imController.fishpi.breezemoon.list(
      page: page.value,
      size: 15,
    );
    if(page.value == 1){
      list.value = res;
      list.refresh();
      refresherController.refreshCompleted();
    }else{
      list.addAll(res);
      list.refresh();
      if(res.isNotEmpty) {
        refresherController.loadComplete();
      }else{
        refresherController.loadNoData();
        isFinished.value = true;
      }
    }
  }

  void onRefresh(){
    initBreezemoon();
  }

  void onLoading(){
    if(isFinished.value) return;
    page.value++;
    initBreezemoon();
  }
}
