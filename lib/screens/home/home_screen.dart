import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/configs/themes/app_icons.dart';
import 'package:questable_quiz_flutter/configs/themes/custom_text_styles.dart';
import 'package:questable_quiz_flutter/configs/themes/ui_parameters.dart';
import 'package:questable_quiz_flutter/controllers/question_group/question_paper/question_group_controller.dart';
import 'package:questable_quiz_flutter/controllers/zoom_drawer_controller.dart';
import 'package:questable_quiz_flutter/screens/home/menu_screen.dart';
import 'package:questable_quiz_flutter/screens/home/question_card.dart';
import 'package:questable_quiz_flutter/widgets/app_circle_button.dart';
import 'package:questable_quiz_flutter/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionGroupController _questionGroupController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            borderRadius: 50.0,
            controller: _.zoomDrawerController,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.defaultStyle,
            menuBackgroundColor: mainGradientLight.colors[0],
            moveMenuScreen: false,
            slideWidth: MediaQuery.of(context).size.width * 0.7,
            menuScreen: const MyMenuScreen(),
            mainScreen: Container(
              decoration: const BoxDecoration(
                gradient: mainGradientDark,
              ),
              // color: Color(0xFF0098b2),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: AppCircleButton(
                              onTap: controller.toggleDrawer,
                              child: const Icon(
                                AppIcons.menuLeft,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Text(
                                  "Hello friends",
                                  style: detailText.copyWith(
                                    color: onSurfaceTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "What do you want to learn today?",
                            style: headerText,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              shrinkWrap: true,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return QuestionCard(
                                  model:
                                      _questionGroupController.allGroups[index],
                                );
                              },
                              separatorBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount:
                                  _questionGroupController.allGroups.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
