import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.theme,
    required this.lable,
    required this.textColor,
    required this.onPressed,
    required this.backgroundColor,
  });

  final ThemeData theme;
  final String lable;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      child: Text(lable),
    );
  }
}
