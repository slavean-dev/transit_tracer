import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {
  const SnackBarContent({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData? icon;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (icon != null) ...[Icon(icon, size: 28)],
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                if (message != null) ...[Text(message!)],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
