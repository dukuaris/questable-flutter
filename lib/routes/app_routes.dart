import 'package:get/get.dart';
import 'package:questable_quiz_flutter/controllers/question_group/question_group_controller.dart';
import 'package:questable_quiz_flutter/controllers/zoom_drawer_controller.dart';
import 'package:questable_quiz_flutter/screens/home/home_screen.dart';
import 'package:questable_quiz_flutter/screens/login/login_screen.dart';
import 'package:questable_quiz_flutter/screens/question/answer_check_screen.dart';
import 'package:questable_quiz_flutter/screens/question/questions_screen.dart';
import 'package:questable_quiz_flutter/controllers/question_group/questions_controller.dart';
import 'package:questable_quiz_flutter/screens/question/result_screen.dart';
import 'package:questable_quiz_flutter/screens/question/test_overview_screen.dart';

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
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: QuestionsScreen.routeName,
          page: () => QuestionsScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
          }),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
      ];
}
