import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/utils/event.dart';
import 'package:fishpi_app/utils/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatRoomLogic extends GetxController{
  ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    scrollToBottom();
    EventBusManager.eventBus.on<NewMsgEvent>().listen((event) {
      print(event.needScrollToBottom);
      scrollToBottom();
    });
    super.onInit();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom(){
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200),curve: Curves.easeIn,);
    });
  }
}