import 'package:flutter/material.dart';
import 'package:transit_tracer/generated/l10n.dart';

class AppDialog {
  static Future<void> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
  }) async {
    final s = S.of(context);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(s.dialogCancel),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
