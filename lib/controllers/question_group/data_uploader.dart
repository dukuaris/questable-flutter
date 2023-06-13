import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:questable_quiz_flutter/models/question_group_model.dart';
import '../../../firebase_ref/loading_status.dart';
import '../../../firebase_ref/references.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus =
      LoadingStatus.loading.obs; // loadingStatus is observable

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //load json file and print path
    final groupsInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains('questable'))
        .toList();
    List<QuestionGroupModel> questionGroups = [];
    for (var group in groupsInAssets) {
      String stringGroupContent = await rootBundle.loadString(group);
      questionGroups
          .add(QuestionGroupModel.fromJson(json.decode(stringGroupContent)));
    }
    // print(
    //     'Items number in questionGroups: ${questionGroups[0].questions![0].questionGroup}');

    for (var group in questionGroups) {
      // Retrieve data from firebase
      var existingGroups = [];
      var existingGroupsSnapshot = await questionGroupsRef.get();
      existingGroupsSnapshot.docs.forEach((doc) {
        existingGroups.add(doc.id);
      });
      var groupId = '';
      var inExistingGroups = existingGroups.contains(group.id);

      if (!inExistingGroups) {
        print("there is no such group");
        var now = DateTime.now();
        var newDoc = await questionGroupsRef.add({
          "subject": group.subject,
          "category": group.category,
          "type": group.type,
          "createdAt": now,
          "userId": group.userId,
          "source": group.source,
          "unit": group.questions == null ? 0 : group.questions!.length,
        });
        groupId = newDoc.id;
      } else {
        groupId = group.id.toString();
        print("there is such group with id of " + groupId);
      }

      for (var question in group.questions!) {
        // Retrieve data from firebase
        var existingQuestions = [];
        var existingQeustionsSnapshot = await multipleChoicesRef.get();
        existingQeustionsSnapshot.docs.forEach((doc) {
          existingQuestions.add(doc.id);
        });
        var inExistingQuestions = existingQuestions.contains(question.id);
        var hasQuestionGroup = false;

        question.questionGroup!.forEach((element) {
          if (existingGroups.contains(element)) {
            hasQuestionGroup = true;
          }
        });

        var now = DateTime.now();

        if (!inExistingQuestions) {
          await multipleChoicesRef.add({
            "question": question.question,
            "correctAnswer": question.correctAnswer,
            "incorrectAnswers": question.incorrectAnswers,
            "category": question.category,
            "subject": question.subject,
            "type": question.type,
            "difficulty": question.difficulty,
            "play": question.play,
            "score": question.score,
            "createdAt": now,
            "updatedAt": now,
            "questionGroup": [groupId],
            "userId": question.userId,
          });
        } else if (!hasQuestionGroup) {
          var exGroup = await multipleChoicesRef.doc(question.id).get();
          var newQuestionGroup = exGroup.data()!['questionGroup'];
          newQuestionGroup.add(groupId);
          await multipleChoicesRef.doc(question.id).update({
            "questionGroup": newQuestionGroup,
            "updatedAt": now,
          });
        }
      }
    }
    loadingStatus.value = LoadingStatus.completed; //1
  }
}
