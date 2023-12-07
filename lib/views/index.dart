import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/utils/app_icon.dart';
import 'package:fishpi_app/views/chat.dart';
import 'package:fishpi_app/views/breezemoon.dart';
import 'package:fishpi_app/views/article.dart';
import 'package:fishpi_app/views/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_style/style.dart';
import '../utils/event.dart';
import '../utils/event_bus.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Fishpi fishpi;
  bool isLogin = false;
  int currentIndex = 0;

  final List<Widget> tabBarBodyItems = [
    const ChatPage(),
    const ArticlePage(),
    const BreezeMoonPage(),
    const UserPage()
  ];

  final List<String> titleList = ["聊天", "文章", "清风明月", "我的"];

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });

    EventBusManager.eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        isLogin = event.isLogin;
      });
    });

    /// 初始化Easyloading组件
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            FishIcon.scan,
            color: Colors.black,
          ),
          title: Text(
            titleList[currentIndex],
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(
              FishIcon.notice,
              color: Colors.black,
            ),
            SizedBox(
              width: 15,
            ),
          ],
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: CommonStyle.primaryColor,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 239, 244, 1),
              border: Border(top: BorderSide(width: 2, color: Colors.black))),
          child: BottomNavigationBar(
            backgroundColor: CommonStyle.primaryColor,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.black,
            selectedLabelStyle:
                const TextStyle(height: 1.8, fontSize: 12, wordSpacing: 10, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(height: 1.8, fontSize: 12, wordSpacing: 10),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  FishIcon.chat,
                  size: 25,
                ),
                label: '聊天',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FishIcon.article,
                  size: 25,
                ),
                label: '文章',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FishIcon.breeze,
                  size: 25,
                ),
                label: '清风明月',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FishIcon.my,
                  size: 25,
                ),
                label: '我的',
              ),
            ],
            onTap: (index) {
              //Handle button tap
              setState(() {
                currentIndex = index;
              });

              tabController.animateTo(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: tabBarBodyItems,
        ));
  }
}
