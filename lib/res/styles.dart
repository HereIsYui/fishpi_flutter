import 'package:flutter/material.dart';

class Styles {
  Styles._();

  static const primaryColor = Color.fromRGBO(240, 211, 94, 1);
  static const commonBorder = Border(
    top: BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid),
    bottom: BorderSide(color: Colors.black, width: 4, style: BorderStyle.solid),
    left: BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid),
    right: BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid),
  );
  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );
}
