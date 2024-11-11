import 'package:flutter/material.dart';

import '../theme.dart';

class ThemeManagerButton extends StatefulWidget {
  const ThemeManagerButton(
      {required this.onPressed, super.key, required this.text, this.color});

  final Function onPressed;
  final String text;
  final Color? color;

  @override
  State<ThemeManagerButton> createState() => _ThemeManagerButtonState();
}

class _ThemeManagerButtonState extends State<ThemeManagerButton> {
  bool pressed = false;
  bool hovered = false;
  final Color pressedColor = ThemeManager.theme.colorScheme.primary;
  final Color hoveredColor =
      ThemeManager.theme.colorScheme.primary.withOpacity(.5);
  final Color initialColor = ThemeManager.theme.colorScheme.onPrimary;

  tapDown(TapDownDetails e) {
    setState(() {
      pressed = true;
    });
  }

  tapUp(TapUpDetails e) {
    setState(() {
      pressed = false;
      widget.onPressed();
    });
  }

  onEnter(_) {
    setState(() {
      hovered = true;
    });
  }

  onExit(_) {
    setState(() {
      hovered = false;
    });
  }

  Color get buttonColor {
    if (widget.color != null) return widget.color!;
    if (hovered && !pressed) return hoveredColor;
    if (pressed) return pressedColor;
    return initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: GestureDetector(
        onTapDown: tapDown,
        onTapUp: tapUp,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(
              color: ThemeManager.theme.colorScheme.onSecondary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 72),
            child: Text(
              textAlign: TextAlign.center,
              style: ThemeManager.label,
              widget.text,
            ),
          ),
        ),
      ),
    );
  }
}
