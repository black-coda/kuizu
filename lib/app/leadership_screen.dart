import 'package:flutter/material.dart';
import 'package:kuizu/theme/component/components.dart';
import 'package:kuizu/theme/theme.dart';
import 'package:provider/provider.dart';

import '../model/player_model.dart';

class LeaderBoardScreen extends StatelessWidget {
  final VoidCallback onResetQuiz;

  const LeaderBoardScreen({super.key, required this.onResetQuiz});

  String dateToReadable(DateTime dt) {
    return '${dt.year}-${dt.month}-${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<Player>();
    final leaderBoard = context.watch<List<Player>>();
    return Padding(
      padding: EdgeInsets.all(ThemeManager.spacing4),
      child: Column(
        children: [
          Row(
            children: [
              Text("Kuizu ga kanryō shimashita", style: ThemeManager.heading1),
              const SeasonsDecoration(smallSize: true)
            ],
          ),
          SizedBox(height: ThemeManager.spacing4),
          ThemeManagerCard(
            child: Column(
              children: [
                Text('Your final score: ${player.currentScore}'),
                Text(
                    'Your highest score: ${player.leaderBoardStats.highestScore} on ${dateToReadable(player.leaderBoardStats.date)}'),
                Text(
                    'Your cumulative score: ${player.leaderBoardStats.cumulativeScore}'),
              ],
            ),
          ),

          //
          SizedBox(height: ThemeManager.spacing4),
          Text("LeaderBoard", style: ThemeManager.heading1),
          Expanded(
            child: ThemeManagerCard(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final leaderBoardPlayer = leaderBoard[index];
                  return ListTile(
                    title: Text(
                      '${leaderBoardPlayer.name}: ${leaderBoardPlayer.leaderBoardStats.highestScore}',
                    ),
                    subtitle: Text(
                        'on ${dateToReadable(leaderBoardPlayer.leaderBoardStats.date)}'),
                  );
                },
                separatorBuilder: (context, idx) {
                  return const Divider();
                },
                itemCount: leaderBoard.length,
              ),
            ),
          ),
          Center(
            child:
                ThemeManagerButton(onPressed: onResetQuiz, text: 'Try Again!'),
          ),
        ],
      ),
    );
  }
}
