import 'package:flutter/material.dart';
import 'package:kuizu/model/player_model.dart';
import 'package:kuizu/theme/theme.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class CoreAppView extends StatefulWidget {
  const CoreAppView({super.key});

  @override
  State<CoreAppView> createState() => _CoreAppViewState();
}

class _CoreAppViewState extends State<CoreAppView> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final player = context.watch<Player>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.appBackground,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Player: ${player.name}",
              style: ThemeManager.label,
            ),
            Text(
              "Score: ${player.currentScore}",
              style: ThemeManager.label,
            )
          ],
        ),
      ),
      body: const Center(),
    );
  }
}
