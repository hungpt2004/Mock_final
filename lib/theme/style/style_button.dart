import 'package:flutter/material.dart';
import 'package:mock_final/theme/action/push_page.dart';
import 'package:mock_final/theme/style/style_color.dart';
import 'package:mock_final/theme/style/style_text.dart';

import '../../view/widget/shopping_cart.dart';

class StyleButton {
  static ButtonStyleLoading(bool isLoad){
    return ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(StyleColor.paleBlueColor),
        shape: WidgetStatePropertyAll(
          isLoad
              ? const CircleBorder()
              : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
        shadowColor: const WidgetStatePropertyAll(Colors.black),
        animationDuration: const Duration(milliseconds: 800),
        elevation: const WidgetStatePropertyAll(4));
  }

  static Widget loading(){
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }


}