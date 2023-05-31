import 'package:flutter/material.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Image.asset(
        'assets/images/questable_transparent.png',
        width: 270,
        height: 270,
      ),
    ));
  }
}
