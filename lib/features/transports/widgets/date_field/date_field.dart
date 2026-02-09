import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.theme,

    required this.onTap,
    required this.dateLable,
    required this.title,
  });

  final String title;
  final ThemeData theme;
  final String dateLable;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(dateLable)),
                  const Icon(Icons.calendar_month),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
