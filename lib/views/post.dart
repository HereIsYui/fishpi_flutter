import 'package:fishpi_app/controller/post_controller.dart';
import 'package:fishpi_app/utils/util.dart';
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
  final PostController postController = Get.put(PostController());
  String token = "";

  @override
  void initState() {
    super.initState();

    token = FpUtil.getString('token');
    postController.init(token);
    postController.getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          child: GetBuilder<PostController>(builder:(controller){
            return postController.postList.list.isNotEmpty ? _articleList() : const Text('is loading');
          }),
        ),
      ),
    );
  }

  Widget _articleList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: postController.postList.list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid
                ),
                bottom: BorderSide(
                    color: Colors.black,
                    width: 4,
                    style: BorderStyle.solid
                ),
                left: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid
                ),
                right: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: ListTile(
              title: Text(
                postController.postList.list[index].titleEmoj,
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                postController.postList.list[index].previewContent,
                style: TextStyle(color:const Color.fromRGBO(74, 74, 87, 1),fontSize: 15.sp),
              ),
            ),
          )
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
