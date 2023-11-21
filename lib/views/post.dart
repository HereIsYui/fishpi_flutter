import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ListTile(
                title: Text("123",style: TextStyle(color: Colors.black),),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
