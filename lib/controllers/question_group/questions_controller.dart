import 'dart:async';

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

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final _questionGroup = Get.arguments as QuestionGroupModel;
    loadData(_questionGroup);
    super.onReady();
  }

  Future<void> loadData(QuestionGroupModel questionGroup) async {
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
      _startTimer(questionGroup.timeSeconds);

      if (questionGroup.questions != null &&
          questionGroup.questions!.isNotEmpty) {
        loadingStatus.value = LoadingStatus.completed;
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

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
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

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = minutes.toString().padLeft(2, '0') +
            ':' +
            seconds.toString().padLeft(2, '0');
        remainSeconds--;
      }
    });
  }
}
