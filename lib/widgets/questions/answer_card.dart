import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/configs/themes/ui_parameters.dart';

enum AnswerStatus {
  correct,
  incorrect,
  answered,
  notanswered,
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  });
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color:
              isSelected ? answerSelectedColor() : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? answerSelectedColor() : answerBorderColor(),
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: correctAnswerColor.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: correctAnswerColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class IncorrectAnswer extends StatelessWidget {
  const IncorrectAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: incorrectAnswerColor.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: incorrectAnswerColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: notAnsweredColor.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: notAnsweredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
