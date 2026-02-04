import 'package:flutter/material.dart';
import 'package:transit_tracer/core/widgets/snack_bar_content/snack_bar_content.dart';
import 'package:transit_tracer/generated/l10n.dart';

class AppSnackBar {
  static void _show(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        content: content,
      ),
    );
  }

  static void showOfflineMessage(BuildContext context) {
    final s = S.of(context);
    _show(
      context,
      SnackBarContent(
        icon: Icons.cloud_off_rounded,
        title: s.offlineModeMessage,
        message: s.offlineSaveMessage,
      ),
    );
  }

  static void showErrorMessage(BuildContext context, String message) {
    _show(context, SnackBarContent(icon: null, title: message, message: null));
  }

  static void showSuccessMessage(BuildContext context, String message) {
    _show(
      context,
      SnackBarContent(
        icon: Icons.check_circle_outline,
        title: message,
        message: null,
      ),
    );
  }
}
