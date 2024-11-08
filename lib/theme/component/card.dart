import 'package:flutter/material.dart';

import '../theme.dart';
import 'seasons_decoration.dart';

class MarketCardWithDecoration extends StatelessWidget {
  const MarketCardWithDecoration({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MarketCard(
      child: Padding(
        padding: EdgeInsets.all(ThemeManager.spacing4),
        child: Column(
          children: [
            child,
            SizedBox(height: ThemeManager.spacing2),
            SeasonsDecoration(
              smallSize: true,
            ),
          ],
        ),
      ),
    );
  }
}

class MarketCard extends StatelessWidget {
  const MarketCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeManager.theme.colorScheme.onSecondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(25),
        color: ThemeManager.theme.colorScheme.onPrimary,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    );
  }
}
