import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kuizu/theme/component/circle.dart';
import 'package:kuizu/theme/component/components.dart';
import 'package:kuizu/theme/theme.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class KuizuIntroScreen extends StatelessWidget {
  final VoidCallback onStartQuiz;
  const KuizuIntroScreen({
    super.key,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Kuizu",
          style: ThemeManager.title,
        ),
        SizedBox(height: ThemeManager.spacing4),
        const ShowCircles(),
        SizedBox(height: ThemeManager.spacing3),
        if (state.quizReady)
          ThemeManagerButton(
            onPressed: onStartQuiz,
            text: "Start Quiz !",
          ),
      ],
    );
  }
}
