import 'package:flutter/material.dart';

class ModalSheetListTile extends StatelessWidget {
  const ModalSheetListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.theme,
  });

  final String title;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: theme.textTheme.bodyMedium),
      onTap: onTap,
    );
  }
}
