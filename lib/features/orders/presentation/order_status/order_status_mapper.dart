import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/presentation/order_status/order_status_ui_model.dart';
import 'package:transit_tracer/generated/l10n.dart';

OrderStatusUiModel getStatusStyle({
  required OrderStatus status,
  required BuildContext context,
  bool isPending = false,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final s = S.of(context);

  if (isPending) {
    return OrderStatusUiModel(
      lable: s.orderStatusSyncing,
      backgroundColor: isDark
          ? Colors.orange.withValues(alpha: 0.15)
          : Colors.orange.shade50,
      textColor: isDark ? Colors.orangeAccent : Colors.orange.shade900,
    );
  }
  switch (status) {
    case OrderStatus.active:
      return OrderStatusUiModel(
        lable: s.orderStatusActive,
        backgroundColor: isDark
            ? const Color(0xFF4ADE80).withValues(alpha: 0.15)
            : const Color(0xFFDCFCE7),
        textColor: isDark ? Colors.white : Colors.black,
      );
    case OrderStatus.inProgress:
      return OrderStatusUiModel(
        lable: s.orderStatusInProgress,
        backgroundColor: isDark
            ? const Color(0xFF93C5FD).withValues(alpha: 0.15)
            : const Color(0xFFDBEAFE),
        textColor: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E40AF),
      );
    case OrderStatus.completed:
      return OrderStatusUiModel(
        lable: s.orderStatusInProgress,
        backgroundColor: isDark
            ? const Color(0xFF94A3B8).withValues(alpha: 0.15)
            : const Color(0xFFF1F5F9),
        textColor: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
      );
    case OrderStatus.archived:
      return OrderStatusUiModel(
        lable: s.orderStatusArchived,
        backgroundColor: isDark
            ? const Color(0xFFFFB86C).withValues(alpha: 0.15)
            : const Color(0xFFFFEDD5),
        textColor: isDark ? const Color(0xFFFFB86C) : const Color(0xFF9A3412),
      );
  }
}
