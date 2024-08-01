import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingBouncingLine.circle(
          backgroundColor: Colors.blue,
          size: 60.0,
        ),
      ),
    );
  }
}
