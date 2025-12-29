import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({super.key, required this.theme, required this.child});

  final ThemeData theme;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
