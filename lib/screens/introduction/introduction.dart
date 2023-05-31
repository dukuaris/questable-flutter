import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/widgets/app_circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/questable_letter_bold_standard.png',
              width: 300,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                'Questable analyzes your content and auto-generates questions to improve your learning effectiveness.'),
            const SizedBox(
              height: 40,
            ),
            AppCircleButton(
                onTap: () => Get.offAndToNamed('/home'),
                child: const Icon(Icons.arrow_forward, size: 55)),
          ],
        ),
      ),
    ));
  }
}
