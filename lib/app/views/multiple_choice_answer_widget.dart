import 'package:flutter/material.dart';
import 'package:kuizu/model/question_model.dart';
import 'package:kuizu/theme/theme.dart';

class MultipleChoiceAnswerButtonWidget extends StatefulWidget {
  const MultipleChoiceAnswerButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.isActive,
  });

  final Function onPressed;
  final String text;
  final bool isSelected;
  final bool isCorrectAnswer;
  final bool isActive;

  @override
  State<MultipleChoiceAnswerButtonWidget> createState() =>
      _MultipleChoiceAnswerButtonWidgetState();
}

class _MultipleChoiceAnswerButtonWidgetState
    extends State<MultipleChoiceAnswerButtonWidget> {
  bool isPressed = false;
  bool isHovered = false;

  // color definition
  final Color pressedColor = ThemeManager.theme.colorScheme.primary;
  final Color hoveredColor =
      ThemeManager.theme.colorScheme.primary.withOpacity(0.5);
  final Color initialColor = ThemeManager.theme.colorScheme.onPrimary;
  final Color inActiveColor = ThemeManager.inactiveButton;
  final Color correctAnswerColor = ThemeManager.correctChoiceColor;
  final Color incorrectAnswerColor = ThemeManager.wrongChoiceColor;

  // Local states synchronized with widget properties
  late bool isActive;
  late bool isCorrect;
  late bool isSelected;

  @override
  void initState() {
    isActive = widget.isActive;
    isCorrect = widget.isCorrectAnswer;
    isSelected = widget.isSelected;
    super.initState();
  }

  tapDown(TapDownDetails e) {
    setState(() {
      isPressed = true; // Button appears pressed.
    });
  }

  tapUp(TapUpDetails e) {
    setState(() {
      isPressed = false; // Button is no longer pressed.
      if (isActive) widget.onPressed(); // Trigger the callback if active.
    });
  }

  onEnter(_) {
    setState(() {
      isHovered = true; // Button is hovered over.
    });
  }

  onExit(_) {
    setState(() {
      isHovered = false; // Button is no longer hovered over.
    });
  }

  Color get buttonColor {
    isActive = widget.isActive;
    isCorrect = widget.isCorrectAnswer;
    isSelected = widget.isSelected;

    final buttonState = (isActive, isPressed, isHovered, isSelected, isCorrect);

    return switch (buttonState) {
      // Button is active and pressed
      (true, true, _, _, _) => pressedColor,

      // Button is active and hovered
      (true, _, true, _, _) => hoveredColor,

      // Button is active and not pressed or hovered
      (true, false, _, _, _) => initialColor,

      // incorrect answer
      (false, _, _, true, false) => incorrectAnswerColor,

      // correct answer
      (false, _, _, _, true) => correctAnswerColor,

      // Button is inactive
      (false, _, _, _, _) => inActiveColor,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: tapDown,
      onTapUp: tapUp,
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
              widget.text,
              textAlign: TextAlign.center,
              style: ThemeManager.label,
            ),
          ),
        ),
      ),
    );
  }
}
