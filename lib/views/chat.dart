import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text('Hello Fishpi!',style: TextStyle(color: Colors.black),),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
