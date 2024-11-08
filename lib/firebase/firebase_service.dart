import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuizu/model/player_model.dart';
import 'package:kuizu/model/question_model.dart';
import 'package:kuizu/utils/name_generator.dart';

import '../model/quiz_model.dart';

class FirebaseService {
  static Future<Player> createUser(UserCredential userCredential) async {
    final existingPlayerDoc = await FirebaseFirestore.instance
        .doc('users/${userCredential.user!.uid}')
        .get();
    Player player;

    // If user exists, this isn't their first time opening the app, return early so we don't overwrite the score

    if (existingPlayerDoc.exists) {
      final Map<String, dynamic> data = existingPlayerDoc.data()!;
      player = Player(
        id: existingPlayerDoc.id,
        name: data['name'] as String,
        currentScore: 0,
        leaderBoardStats: LeaderBoardStats(
          highestScore: data['leaderBoardStats']['highestScore'] as int,
          date: (data['leaderBoardStats']['date'] as Timestamp).toDate(),
          cumulativeScore: data['leaderBoardStats']['cumulativeScore'] as int,
        ),
      );
    } else {
      // The document doesn't exist, so this is the first time they're opening the app
      // Create a username and add them to Firestore
      player = Player(
        id: userCredential.user!.uid,
        name: generateRandomPlayerName(),
        leaderBoardStats: LeaderBoardStats(
          date: DateTime.now(),
        ),
      );

      // Create user in Firestore, in order to track score
      await FirebaseFirestore.instance.doc('users/${player.id}').set(
        {
          'name': player.name,
          'id': player.id,
          'score': player.currentScore,
          'leaderBoardStats': {
            'highestScore': player.leaderBoardStats.highestScore,
            'date': player.leaderBoardStats.date,
            'cumulativeScore': player.leaderBoardStats.cumulativeScore,
          },
        },
      );
    }
    return player;
  }

  static Future<QuerySnapshot> getAllQuestions() =>
      FirebaseFirestore.instance.collection('questions').get();

  static Future<Quiz> createQuiz() async {
    return await getAllQuestions().then<Quiz>(
      (QuerySnapshot value) {
        final List<Question> questions = value.docs.map(
          (doc) {
            final data = doc.data()!;
            if (data
                case <String, dynamic>{
                  'type': 'textQuestion' || 'imageQuestion',
                  'category': String _,
                  'answer': _,
                }) {
              return Question.fromFirestore(doc);
            } else {
              throw const FormatException(
                  "Incoming Firestore Question Data is malformed");
            }
          },
        ).toList();

        final Quiz quiz = Quiz(questionList: []);
        questions.shuffle();
        final List<Question> questionsForQuizLength =
            questions.take(quiz.length).toList();
        quiz.addQuestion(questionsForQuizLength);
        return quiz;
      },
    );
  }

  static Future<void> incrementScore(Player player) async {
    player.currentScore++;
    final json = player.toJson();
    await FirebaseFirestore.instance.doc('users/${player.id}').update(json);
  }

  static Future<void> updateUserLeaderBoardStats(Player player) async {
    final json = player.toJson();
    await FirebaseFirestore.instance.doc('users/${player.id}').update(json);
  }

  static Future<void> resetCurrentScore(Player player) async {
    player.currentScore = 0;
    final json = player.toJson();
    FirebaseFirestore.instance.doc('users/${player.id}').update(json);
  }

  static Stream<Player> playerStream(Player player) {
    return FirebaseFirestore.instance
        .doc('users/${player.id}')
        .snapshots()
        .map((event) => Player.fromJson(event.data()!));
  }

  static Stream<List<Player>> leaderBoardStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('leaderBoardStats.cumulativeScore', isNotEqualTo: 0)
        .limit(30)
        .snapshots()
        .map((event) {
      var players = event.docs
          .map((snapshot) => Player.fromJson(snapshot.data()))
          .toList();
      players.sort((a, b) => b.leaderBoardStats.cumulativeScore
          .compareTo(a.leaderBoardStats.cumulativeScore));

      return players;
    });
  }
}
