import 'package:flutter/cupertino.dart';

class StyleSpace {
  static Widget space([double height = 0, double width = 0]){
    return SizedBox(
      height: height,
      width: width,
    );
  }
}