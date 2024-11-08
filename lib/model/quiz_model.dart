import 'question_model.dart';

class Quiz {
  final List<Question> questionList;
  final int length;

  Quiz({required this.questionList, this.length = 5});

  List<Question> addQuestion(List<Question> newQuestion) {
    questionList.addAll(newQuestion);
    return questionList;
  }
}
