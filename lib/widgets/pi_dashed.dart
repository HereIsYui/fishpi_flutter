import 'package:flutter/material.dart';

class PiDashed extends StatelessWidget {
  final double dashedWidth;
  final double dashedHeight;
  final Color color;

  const PiDashed(
      {super.key,
      this.dashedWidth = 1,
      this.dashedHeight = 1,
      this.color = const Color(0xffff0000)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dashedWidth)).floor();
        //根据宽度计算个数
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (int index) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
