import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String image;
  final bool isAssets;
  final double size;
  final double borderWidth;
  final Color borderColor;

  const Avatar({
    Key? key,
    required this.image,
    this.isAssets = false,
    this.size = 50,
    this.borderWidth = 2,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: isAssets
            ? Image.asset(
                image,
                width: size,
                fit: BoxFit.cover,
              )
            : Image.network(
                image,
                width: size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
