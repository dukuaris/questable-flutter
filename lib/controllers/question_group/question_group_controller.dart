import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:questable_quiz_flutter/controllers/auth_controller.dart';
import 'package:questable_quiz_flutter/firebase_ref/references.dart';
import 'package:questable_quiz_flutter/models/question_group_model.dart';
import 'package:questable_quiz_flutter/services/firebase_storage_service.dart';
import 'package:questable_quiz_flutter/screens/question/questions_screen.dart';

class QuestionGroupController extends GetxController {
  final allGroupImages = <String>[].obs;
  final allGroups = <QuestionGroupModel>[].obs;

  var AppLogger = Logger();

  @override
  void onReady() {
    getAllGroups();
    super.onReady();
  }

  Future<void> getAllGroups() async {
    List<String> imgName = [
      "multiple-choice",
      "true-false",
      'fill-in-the-blank',
      'matching',
      'short-answer',
      'ranking',
    ];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionGroupsRef.get();
      final groupList = data.docs
          .map((group) => QuestionGroupModel.fromSnapshot(group))
          .toList();

      allGroups.assignAll(groupList);

      for (var group in groupList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(group.type);

        group.imgUrl = imgUrl;
      }
      allGroups.assignAll(groupList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToQuestions({
    required QuestionGroupModel group,
    bool tryAgain = false,
  }) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionsScreen.routeName,
            arguments: group, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionsScreen.routeName, arguments: group);
      }
    } else {
      print('The subject is ${group.subject}');
      _authController.showLoginAlertDialogue();
    }
  }
}
