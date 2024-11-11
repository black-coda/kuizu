import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


class Player {
  final String id;
  final String? name;
  int currentScore;
  LeaderBoardStats leaderBoardStats;
  Player({
    required this.id,
    this.name,
    this.currentScore = 0,
    required this.leaderBoardStats,
  });

  void updateLeaderBoardStats(){
    leaderBoardStats.cumulativeScore += currentScore;
    if(currentScore > leaderBoardStats.highestScore){
      leaderBoardStats.highestScore = currentScore;
      leaderBoardStats.date = DateTime.now();
    }
  }

  static Player fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String _,
        'name': String _,
        'score': int _,
        'leaderBoardStats': {
          'highestScore': int _,
          'date': Timestamp _,
          'cumulativeScore': int _,
        }
      } =>
        Player(
            id: json["id"] as String,
            currentScore: json["score"] as int,
            name: json['name'] as String,
            leaderBoardStats: LeaderBoardStats.fromJson(
                json["leaderBoardStats"] as Map<String, dynamic>)),
      _ => throw const FormatException("Invalid json format"),
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'score': currentScore,
      'leaderBoardStats': leaderBoardStats.toJson(),
    };
  }
}

class LeaderBoardStats {
  int highestScore;
  DateTime date;
  int cumulativeScore;
  LeaderBoardStats({
    this.highestScore = 0,
    required this.date,
    this.cumulativeScore = 0,
  });

  static LeaderBoardStats fromJson(Map<String, dynamic> leaderBoardStatsJson) =>
      switch (leaderBoardStatsJson) {
        {
          'highestScore': int highestScore,
          'date': Timestamp date,
          'cumulativeScore': int cumulativeScore,
        } =>
          LeaderBoardStats(
              highestScore: highestScore,
              date: date.toDate(),
              cumulativeScore: cumulativeScore),
        _ => throw const FormatException(),
      };

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'highestScore': highestScore,
      'date': date,
      'cumulativeScore': cumulativeScore,
    };
  }

  String toJsonString() => json.encode(toJson());
}
