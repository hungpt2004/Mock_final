import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_final/theme/style/style_color.dart';
import 'package:mock_final/theme/style/style_text.dart';

class StyleAppBar {
  static Widget(String text){
    return AppBar(
      title: Column(
        children: [
          Text(
            text,
            style: StyleText.styleAirbnb(30, FontWeight.w500, Colors.white),
          ),
        ],
      ),
      backgroundColor: StyleColor.darkBlueColor,
      centerTitle: true,
    );
  }
}