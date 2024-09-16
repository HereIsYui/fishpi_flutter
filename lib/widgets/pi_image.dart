import 'package:cached_network_image/cached_network_image.dart';
import 'package:fishpi_app/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PiImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final BoxFit? fit;

  const PiImage({
    required this.imgUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, e) => _buildLoadingImg(),
      errorWidget: (_, a, e) => _buildErrorImg(),
    );
  }

  Widget _buildLoadingImg() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '图片加载中...',
        style: TextStyle(
          color: Styles.primaryTextColor,
          fontSize: 20.sp,
        ),
      ),
    );
  }

  Widget _buildErrorImg() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '图片加载失败',
        style: TextStyle(
          color: Styles.primaryTextColor,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
