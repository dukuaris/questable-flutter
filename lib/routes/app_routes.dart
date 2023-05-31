import 'package:get/get.dart';
import 'package:questable_quiz_flutter/controllers/question_group/question_paper/question_group_controller.dart';
import 'package:questable_quiz_flutter/controllers/zoom_drawer_controller.dart';
import 'package:questable_quiz_flutter/screens/home/home_screen.dart';

import '../screens/introduction/introduction.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/introduction',
          page: () => AppIntroductionScreen(),
        ),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(
                QuestionGroupController(),
              );
              Get.put(MyZoomDrawerController());
            })),
      ];
}
