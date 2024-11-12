import 'package:flutter/material.dart';

import '../theme.dart';

typedef TextChangedCallback = void Function(String?);

class ThemeManagerTextField extends StatefulWidget {
  const ThemeManagerTextField({super.key, required this.onChange});

  final TextChangedCallback onChange;

  @override
  State<ThemeManagerTextField> createState() => _ThemeManagerTextFieldState();
}

class _ThemeManagerTextFieldState extends State<ThemeManagerTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: ThemeManager.theme.colorScheme.onPrimary,
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          widget.onChange(value);
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(ThemeManager.spacing4),
          fillColor: ThemeManager.theme.colorScheme.onPrimary,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeManager.theme.colorScheme.onSecondary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
