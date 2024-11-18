import 'package:fishpi_app/widgets/pi_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'collection_list_logic.dart';

class CollectionListPage extends StatelessWidget {
  final CollectionListLogic logic = Get.put(CollectionListLogic());

  CollectionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PiTitleBar.back(
        title: '典藏馆',
      ),
    );
  }
}
