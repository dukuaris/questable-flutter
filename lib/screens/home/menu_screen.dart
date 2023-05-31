import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/configs/themes/ui_parameters.dart';
import 'package:questable_quiz_flutter/controllers/zoom_drawer_controller.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: UIParameters.mobileScreenPadding,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: onSurfaceTextColor,
              ),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                    color: Colors.black,
                    onPressed: () {
                      controller.toggleDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
