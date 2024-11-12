import 'package:flutter/material.dart';

import '../theme.dart';
import 'circle.dart';

typedef BoolSelectionCallback = void Function(bool);

class ThemeManagerSwitch extends StatefulWidget {
  const ThemeManagerSwitch({super.key, required this.onTap});

  final BoolSelectionCallback onTap;

  @override
  State<ThemeManagerSwitch> createState() => _ThemeManagerSwitchState();
}

class _ThemeManagerSwitchState extends State<ThemeManagerSwitch> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 36,
        width: 48,
        child: GestureDetector(
          onTap: () {
            setState(() {
              val = !val;
              widget.onTap(val);
            });
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 48,
                  height: 14,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20),
                    color: val
                        ? ThemeManager.theme.colorScheme.scrim
                        : ThemeManager.theme.colorScheme.shadow,
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: val ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 100),
                child: Circle(
                  size: 24,
                  color: ThemeManager.theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
