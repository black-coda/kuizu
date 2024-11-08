import 'package:flutter/material.dart';

import '../theme.dart';

class InSeasonHeading extends StatelessWidget {
  const InSeasonHeading(this.dateString, {super.key});

  final String dateString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(dateString.toUpperCase(), style: ThemeManager.subheading1),
          Text('In season today', style: ThemeManager.heading1),
        ],
      ),
    );
  }
}
