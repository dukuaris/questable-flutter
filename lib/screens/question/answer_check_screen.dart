import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/configs/themes/custom_text_styles.dart';
import 'package:questable_quiz_flutter/controllers/question_group/questions_controller.dart';
import 'package:questable_quiz_flutter/screens/question/result_screen.dart';
import 'package:questable_quiz_flutter/widgets/common/background_decoration.dart';
import 'package:questable_quiz_flutter/widgets/common/custom_app_bar.dart';
import 'package:questable_quiz_flutter/widgets/content_area.dart';
import 'package:questable_quiz_flutter/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});
  static const String routeName = '/answercheckscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
              style: appBarTS,
            )),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(controller.currentQuestion.value!.question),
                        const SizedBox(height: 20),
                        GetBuilder<QuestionsController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers[index];
                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;
                                final String answerText =
                                    '  ${index + 1}.  $answer';
                                if (correctAnswer == selectedAnswer &&
                                    answer == selectedAnswer) {
                                  return CorrectAnswer(answer: answerText);
                                } else if (selectedAnswer == null) {
                                  return NotAnswered(answer: answerText);
                                } else if (correctAnswer != selectedAnswer &&
                                    answer == selectedAnswer) {
                                  return IncorrectAnswer(answer: answerText);
                                } else if (correctAnswer == answer) {
                                  return CorrectAnswer(answer: answerText);
                                }

                                return AnswerCard(
                                  answer: answerText,
                                  onTap: () {},
                                  isSelected: false,
                                );
                              },
                              separatorBuilder: (_, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: controller
                                  .currentQuestion.value!.answers.length,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
