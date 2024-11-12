import 'package:flutter/material.dart';
import 'package:kuizu/model/question_model.dart';
import 'package:kuizu/theme/component/card.dart';

abstract class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key});
}

class TextQuestionWidget extends QuestionWidget {
  const TextQuestionWidget({super.key, required this.textQuestion});

  final TextQuestion textQuestion;

  @override
  Widget build(BuildContext context) {
    return ThemeManagerCardWithDecoration(
      child: Text(
        "Question: ${textQuestion.questionBody}",
      ),
    );
  }
}

class ImageQuestionWidget extends QuestionWidget {
  final ImageQuestion imageQuestion;

  const ImageQuestionWidget({super.key, required this.imageQuestion});
  @override
  Widget build(BuildContext context) {
    return ThemeManagerCard(
      child: Column(
        children: [
          Image.asset(imageQuestion.imagePath),
          const Text("What describes the above Image?")
        ],
      ),
    );
  }
}
