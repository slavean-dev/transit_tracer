import 'package:flutter/material.dart';

class BaseFormFieldContainer extends StatelessWidget {
  const BaseFormFieldContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}
