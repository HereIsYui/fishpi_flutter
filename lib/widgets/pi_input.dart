import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/styles.dart';

class PiInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onUserNameChanged;
  final String? hintText;
  final Icon? prefixIcon;

  const PiInput({
    required this.controller,
    required this.onUserNameChanged,
    this.hintText,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 50, 0),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        enabledBorder: Styles.inputBorder,
        focusedBorder: Styles.inputBorder,
        border: Styles.inputBorder,
      ),
      keyboardType: TextInputType.text,
      onChanged: onUserNameChanged,
    );
  }
}
