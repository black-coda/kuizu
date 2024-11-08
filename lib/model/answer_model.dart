sealed class Answer {
  final String correctAnswer;

  Answer({required this.correctAnswer});

  static Answer fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "type": "openTextAnswer",
        "correctAnswer": String correctAnswer,
      } =>
        OpenTextAnswer(correctAnswer: correctAnswer),
      {
        "type": "multipleChoiceAnswer",
        'correctAnswer': String correctAnswer,
        'answerOptions': List<dynamic> answerOptions,
      } =>
        MultipleChoiceAnswer(
          correctAnswer: correctAnswer,
          answerOptions: answerOptions.cast<String>(),
        ),
      {
        "type": "booleanAnswer",
        "correctAnswer": String correctAnswer,
      } =>
        BooleanAnswer(correctAnswer: correctAnswer),
      _ => throw const FormatException("Answers doesn't match pattern"),
    };
  }

  static Map<String, dynamic> toJson(Answer answer){
    return switch(answer){
     OpenTextAnswer textAnswer => {
          'type': 'openTextAnswer',
          'correctAnswer': textAnswer.correctAnswer
        },
      BooleanAnswer boolAnswer => {
          'type': 'booleanAnswer',
          'correctAnswer': boolAnswer.correctAnswer
        },
      MultipleChoiceAnswer multiChoice => {
          'type': 'multipleChoiceAnswer',
          'correctAnswer': multiChoice.correctAnswer,
          'answerOptions': multiChoice.answerOptions
        }


    };
  }

}

class OpenTextAnswer extends Answer {
  OpenTextAnswer({required super.correctAnswer});

  Map<String, dynamic> toJson() {
    return {
      'type': 'openTextAnswer',
      'correctAnswer': correctAnswer,
    };
  }
}

class BooleanAnswer extends Answer {
  BooleanAnswer({required super.correctAnswer});

  Map<String, dynamic> toJson() {
    return {
      'type': 'booleanAnswer',
      'correctAnswer': correctAnswer,
    };
  }
}

class MultipleChoiceAnswer extends Answer {
  MultipleChoiceAnswer(
      {required super.correctAnswer, required this.answerOptions});

  final List<String> answerOptions;
}
