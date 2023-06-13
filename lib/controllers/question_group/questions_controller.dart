import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/firebase_ref/loading_status.dart';
import 'package:questable_quiz_flutter/models/question_group_model.dart';
import 'package:questable_quiz_flutter/firebase_ref/references.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionGroupModel questionGroupModel;
  final allQuestions = <MultipleChoice>[].obs;
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  Rxn<MultipleChoice> currentQuestion = Rxn<MultipleChoice>();

  @override
  void onReady() {
    final _questionGroup = Get.arguments as QuestionGroupModel;
    print(_questionGroup.subject);
    loadData(_questionGroup);
    super.onReady();
  }

  void loadData(QuestionGroupModel questionGroup) async {
    questionGroupModel = questionGroup;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await multipleChoicesRef
              .where('questionGroup', arrayContains: questionGroup.id)
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => MultipleChoice.fromSnapshot(snapshot))
          .toList();

      questionGroup.questions = questions;
      currentQuestion.value = questionGroup.questions![0];

      if (questionGroup.questions != null &&
          questionGroup.questions!.isNotEmpty) {
        loadingStatus.value = LoadingStatus.completed;
        print("Completed");
      } else {
        loadingStatus.value = LoadingStatus.error;
      }

      allQuestions.assignAll(questionGroup.questions!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void selectedAnswer(String answer) {
    update(['answers_list']);
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }
}
