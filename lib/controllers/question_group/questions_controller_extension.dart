import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/controllers/auth_controller.dart';
import 'package:questable_quiz_flutter/controllers/question_group/questions_controller.dart';
import 'package:questable_quiz_flutter/firebase_ref/references.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) * 100;
    // * (questionGroupModel.timeSeconds - remainSeconds) /
    // questionGroupModel.timeSeconds *
    // 100;
    return points.toStringAsFixed(2);
  }

  //   Future<void> saveTestResults() {
  //   var batch = fireStore.batch();
  //   User? _user = Get.find<AuthController>().getUser();
  //   if (_user == null) {
  //     return;
  //   }
  //   batch.set(userRef.doc(_user.email).collection('myrecent_tests').doc(questionGroupModel.id),{

  //   }
  //       );
  // }
}
