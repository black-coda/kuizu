import 'package:flutter/material.dart';

import '../theme.dart';

class Circle extends StatelessWidget {
  Circle({required this.size, required this.color, this.number, super.key});

  final double size;
  final Color color;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: ThemeManager.theme.colorScheme.onSecondary,
            width: 2,
          )),
      child: number != null
          ? Center(
              child: Text(number.toString(), style: ThemeManager.heading2),
            )
          : null,
    );
  }
}

double small = 16;
double medium = 22;
double large = 60;

class ShowCircles extends StatelessWidget {
  const ShowCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Circle(
          color: ThemeManager.theme.colorScheme.tertiary,
          size: small,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.tertiary,
          size: medium,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.secondary,
          size: small,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.secondary,
          size: medium,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.scrim,
          size: small,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.scrim,
          size: medium,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.primary,
          size: small,
        ),
        Circle(
          color: ThemeManager.theme.colorScheme.primary,
          size: medium,
        ),
      ],
    );
  }
}
