import 'package:flutter/material.dart';
import 'package:kuizu/theme/component/circle.dart';

import '../theme.dart';

class SeasonsDecoration extends StatelessWidget {
  const SeasonsDecoration({this.smallSize = false, super.key});

  final bool smallSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Circle(
          color: ThemeManager.theme.colorScheme.tertiary,
          size: smallSize ? small : medium,
        ),
        const SizedBox(width: 8),
        Circle(
          color: ThemeManager.theme.colorScheme.secondary,
          size: smallSize ? small : medium,
        ),
        const SizedBox(width: 8),
        Circle(
          color: ThemeManager.theme.colorScheme.scrim,
          size: smallSize ? small : medium,
        ),
        const SizedBox(width: 8),
        Circle(
          color: ThemeManager.theme.colorScheme.primary,
          size: smallSize ? small : medium,
        ),
      ],
    );
  }
}
