import 'package:flutter/material.dart';

import '../theme.dart';

class Toggle extends StatefulWidget {
  const Toggle({super.key});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  String selected = 'Facts & Info';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SegmentedButton<String>(
              showSelectedIcon: false,
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all<Color>(
                    ThemeManager.theme.colorScheme.primary),
                side: WidgetStateProperty.all(
                  BorderSide.lerp(
                      BorderSide(
                        color: ThemeManager.theme.colorScheme.onSecondary,
                        width: 2,
                      ),
                      BorderSide(
                        color: ThemeManager.theme.colorScheme.onSecondary,
                        width: 2,
                      ),
                      10),
                ),
              ),
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'Facts & Info',
                  label: Text(
                    'Facts & Info',
                    style: ThemeManager.heading3,
                  ),
                ),
                ButtonSegment<String>(
                  value: 'Trivia',
                  label: Text(
                    'Trivia',
                    style: ThemeManager.heading3,
                  ),
                )
              ],
              selected: <String>{selected},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected = newSelection.first;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
