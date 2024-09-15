import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'breezemoons_logic.dart';

class BreezemoonsPage extends StatelessWidget {
  final BreezemoonsLogic logic = Get.put(BreezemoonsLogic());

  BreezemoonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
