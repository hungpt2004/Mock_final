import 'package:flutter/cupertino.dart';

import '../route/slide_page_route_widget.dart';

class StylePush {
  static void navigatorPush(BuildContext context, Widget page){
    Navigator.push(
        context,
        SlidePageRoute(
            page: page,
            beginOffset: const Offset(1, 0),
            endOffset: Offset.zero,
            duration: const Duration(milliseconds: 1000)));
  }
}