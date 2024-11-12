import 'package:flutter/material.dart';
import 'package:kuizu/app/app_state.dart';
import 'package:kuizu/model/answer_model.dart';
import 'package:kuizu/theme/component/button.dart';
import 'package:kuizu/theme/component/switch.dart';
import 'package:kuizu/theme/component/text_field.dart';
import 'package:kuizu/theme/theme.dart';
import 'package:provider/provider.dart';

abstract class AnswerWidget extends StatefulWidget {
  const AnswerWidget({super.key});
}

class TextAnswerWidget extends AnswerWidget {
  const TextAnswerWidget(this.answer, {super.key});

  final OpenTextAnswer answer;

  @override
  State<TextAnswerWidget> createState() => _TextAnswerWidgetState();
}

class _TextAnswerWidgetState extends State<TextAnswerWidget> {
  String? textValue;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Column(
      children: [
        ThemeManagerTextField(
          onChange: (value) {
            textValue = value;
          },
        ),
        SizedBox(height: ThemeManager.spacing4),
        ThemeManagerButton(
          onPressed: () {
            if (textValue != null) {
              state.validateAnswer(textValue ?? "");
            }
          },
          text: "Submit Answer",
        ),
      ],
    );
  }
}

class BooleanAnswerWidget extends AnswerWidget {
  const BooleanAnswerWidget(this.answer, {super.key});

  final BooleanAnswer answer;

  @override
  State<BooleanAnswerWidget> createState() => _BooleanAnswerWidgetState();
}

class _BooleanAnswerWidgetState extends State<BooleanAnswerWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("False"),
            ThemeManagerSwitch(
              onTap: (value) {
                setState(() {
                  _selected = value;
                });
              },
            ),
            const Text("True"),
          ],
        ),
        SizedBox(height: ThemeManager.spacing4),
        ThemeManagerButton(
          onPressed: () {
            state.validateAnswer(_selected.toString());
          },
          text: "Submit Answer",
        ),
      ],
    );
  }
}

const List<String> multipleChoiceAnswerKey = ['A', 'B', 'C', 'D'];

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget(this.answer, {super.key});

  final MultipleChoiceAnswer answer;

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  int _selectedButtonIndex = -1;

  bool _isActive = true;

  List<Widget> _buildbuttons(AppState state) {
    final answer = widget.answer.answerOptions;
    return answer.map((answerOption) {
      final bool isCorrectAnswer = widget.answer.correctAnswer == answerOption;
      final int index = widget.answer.answerOptions.indexOf(answerOption);
      final bool isSelected = index == _selectedButtonIndex;
      return Padding(
        padding: EdgeInsets.all(ThemeManager.spacing8),
        child: SizedBox(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
