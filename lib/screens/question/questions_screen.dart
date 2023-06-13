import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/configs/themes/custom_text_styles.dart';
import 'package:questable_quiz_flutter/configs/themes/ui_parameters.dart';
import 'package:questable_quiz_flutter/controllers/question_group/questions_controller.dart';
import 'package:questable_quiz_flutter/firebase_ref/loading_status.dart';
import 'package:questable_quiz_flutter/widgets/common/background_decoration.dart';
import 'package:questable_quiz_flutter/widgets/common/main_button.dart';
import 'package:questable_quiz_flutter/widgets/common/question_place_holder.dart';
import 'package:questable_quiz_flutter/widgets/content_area.dart';
import 'package:questable_quiz_flutter/widgets/questions/answer_card.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  static const String routeName = '/questionsscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                  child: ContentArea(child: QuestionScreenHolder()),
                ),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestion.value!.question,
                            style: questionTS,
                          ),
                          GetBuilder<QuestionsController>(
                              id: 'answers_list',
                              builder: (context) {
                                List<String> answers = [
                                  ...controller
                                      .currentQuestion.value!.incorrectAnswers,
                                  controller
                                      .currentQuestion.value!.correctAnswer
                                ];
                                answers.shuffle();
                                print(answers.length);
                                return ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: answers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final answer = answers[index];

                                    return AnswerCard(
                                      answer: '  ${index + 1}.  $answer',
                                      onTap: () {
                                        controller.selectedAnswer(answer);
                                      },
                                      // isSelected:
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 10,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onTap: () {
                              controller.prevQuestion();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                            visible: controller.loadingStatus.value ==
                                LoadingStatus.completed,
                            child: MainButton(
                              onTap: () {
                                controller.isLastQuestion
                                    ? Container()
                                    : controller.nextQuestion();
                              },
                              title: controller.isLastQuestion
                                  ? 'Completed'
                                  : 'Next',
                            )),
                      )
                    ],
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
