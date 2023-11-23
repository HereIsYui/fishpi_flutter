import 'package:fishpi/fishpi.dart';
import 'package:fishpi_app/views/chat.dart';
import 'package:fishpi_app/views/circle.dart';
import 'package:fishpi_app/views/post.dart';
import 'package:fishpi_app/views/user.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
    ChatPage(),
    PostPage(),
    CirclePage(),
    UserPage()
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.qr_code_scanner,color: Colors.black,),
          title: Text(titleList[currentIndex],style: const TextStyle(color: Colors.black),),
          actions: const [
            Icon(Icons.notifications,color: Colors.black,),
            SizedBox(width: 15,),
          ],
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(238, 239, 244, 1),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: const Color.fromRGBO(236, 212, 99, 1),
          height: 50,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          index: currentIndex,
          items: const <Widget>[
            Icon(
              Icons.chat,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.find_in_page,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            //Handle button tap
            print('index: $index');
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
        body: TabBarView(
          controller: tabController,
          children: tabBarBodyItems,
        ));
  }
}
