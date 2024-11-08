// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:kuizu/firebase/firebase_service.dart';
import 'package:kuizu/model/answer_model.dart';

import 'package:kuizu/model/player_model.dart';
import 'package:kuizu/model/question_model.dart';
import 'package:kuizu/model/quiz_model.dart';

class AppState extends ChangeNotifier {
  final Player player;
  Quiz quiz;

  AppState({
    required this.player,
    required this.quiz,
  });

  bool quizComplete = false;
  bool quizReady = true;
  int _currentQuestionIndex = 0;

  Question get currentQuestion =>
      quiz.questionList.elementAt(_currentQuestionIndex);

  Answer get currentAnswer =>
      quiz.questionList.elementAt(_currentQuestionIndex).answer;

  bool validateAnswer(String value) {
    final isCorrect = currentAnswer.correctAnswer == value;
    if (isCorrect) FirebaseService.incrementScore(player);
    return isCorrect;
  }

  void nextQuestion() {
    if (_currentQuestionIndex + 1 == quiz.length) {
      quizComplete = true;
      completeQuiz();
    }

    _currentQuestionIndex++;
    notifyListeners();
  }

  completeQuiz() async {
    player.updateLeaderBoardStats();
    await FirebaseService.updateUserLeaderBoardStats(player);
  }

  resetQuiz() async {
    quizReady = false;
    notifyListeners();
    _currentQuestionIndex = 0;
    quizComplete = false;
    await FirebaseService.resetCurrentScore(player);
    quiz = await FirebaseService.createQuiz();
    quizReady = true;
    notifyListeners();
  }
}
