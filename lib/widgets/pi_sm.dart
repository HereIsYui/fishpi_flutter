import 'package:flutter/material.dart';

// 斑马纹具体实现类
class PiZebraStripesBack extends StatefulWidget {
  const PiZebraStripesBack({
    this.width = 0,
    this.height = 0,
    this.spacing = 4,
    this.lineWidth = 4,
    this.lineColor = Colors.transparent,
    this.borderRaduis = 0,
    super.key,
  });

  final double width; // 容器宽度
  final double height; // 容器高度
  final double lineWidth; // 斑马纹宽度
  final double spacing; // 间距
  final double borderRaduis; // 容器圆角
  final Color lineColor; // 斑马纹颜色

  @override
  State<StatefulWidget> createState() => _ZebraStripesBackState();
}

class _ZebraStripesBackState extends State<PiZebraStripesBack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRaduis)),
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _ZebraStripesBackPainter(
            maxWidth: widget.width,
            maxHeight: widget.height,
            spacing: widget.spacing,
            lineWidth: widget.lineWidth,
            lineColor: widget.lineColor,
            borderRaduis: widget.borderRaduis,
          ),
        ));
  }
}

class _ZebraStripesBackPainter extends CustomPainter {
  _ZebraStripesBackPainter({
    this.maxWidth = 0,
    this.maxHeight = 0,
    this.spacing = 4,
    this.lineWidth = 4,
    this.lineColor = Colors.black12,
    this.borderRaduis = 0,
  });

  final double maxWidth;
  final double maxHeight;
  final double spacing;
  final double lineWidth;
  final Color lineColor;
  final double borderRaduis;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = lineColor
      ..strokeWidth = lineWidth;

    int number = 0; // 个数
    int fillNumber = 0; // 填充个数
    double lineAndSpace = lineWidth * 1.41 + spacing; // 单个条纹宽 + 间距宽
    if (lineWidth > 0) {
      number = (maxWidth / lineAndSpace).ceil();
      fillNumber = (maxHeight / lineAndSpace).ceil(); // 填充个数
    }

    double deviation = lineWidth / 2.82; // x y轴偏移量 = width / 2倍根号2
    for (int i = -fillNumber; i < number; i++) {
      var left = lineAndSpace * i - deviation;
      double dx = left;
      double dy = -deviation;
      double dx1 = left + maxHeight;
      double dy1 = maxHeight + deviation;
      canvas.drawLine(
        Offset(dx, dy),
        Offset(dx1, dy1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
