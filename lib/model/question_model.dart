import 'package:cloud_firestore/cloud_firestore.dart';

import 'answer_model.dart';

sealed class Question {
  String id;
  String category;
  Answer answer;

  Question({
    required this.id,
    required this.category,
    required this.answer,
  });

  static Question fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "type": "textQuestion",
        "category": String category,
        "answer": Map<String, dynamic> answer,
        "questionBody": String body,
        "id": String id,
      } =>
        TextQuestion(
          category: category,
          id: id,
          answer: Answer.fromJson(answer),
          questionBody: body,
        ),
      {
        "type": "imageQuestion",
        "category": String category,
        "answer": Map<String, dynamic> answer,
        "imagePath": String imagePath,
        "id": String id,
      } =>
        ImageQuestion(
          id: id,
          category: category,
          answer: Answer.fromJson(answer),
          imagePath: imagePath,
        ),
      _ => throw const FormatException(),
    };
  }

  static Question fromFirestore(QueryDocumentSnapshot snapshot) {
    final String id = snapshot.reference.id;
    final Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    json["id"] = id;
    return Question.fromJson(json);
  }
}

class TextQuestion extends Question {
  TextQuestion({
    required super.id,
    required super.category,
    required super.answer,
    required this.questionBody,
  });

  final String questionBody;
}

class ImageQuestion extends Question {
  final String imagePath;
  ImageQuestion({
    required super.id,
    required super.category,
    required super.answer,
    required this.imagePath,
  });
}
