import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/utils/order_status_mapper/model/order_status_ui.dart';

OrderStatusUiModel getStatusStyle(OrderStatus status, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  switch (status) {
    case OrderStatus.active:
      return OrderStatusUiModel(
        lable: 'Active',
        backgroundColor: isDark
            ? const Color(0xFF4ADE80).withValues(alpha: 0.15)
            : const Color(0xFFDCFCE7),
        textColor: isDark ? Colors.white : Colors.black,
      );
    case OrderStatus.inProgress:
      return OrderStatusUiModel(
        lable: 'In progress',
        backgroundColor: isDark
            ? const Color(0xFF93C5FD).withValues(alpha: 0.15)
            : const Color(0xFFDBEAFE),
        textColor: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E40AF),
      );
    case OrderStatus.completed:
      return OrderStatusUiModel(
        lable: 'Completed',
        backgroundColor: isDark
            ? const Color(0xFF94A3B8).withValues(alpha: 0.15)
            : const Color(0xFFF1F5F9),
        textColor: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
      );
    case OrderStatus.archived:
      return OrderStatusUiModel(
        lable: 'Archived',
        backgroundColor: isDark
            ? const Color(0xFFFFB86C).withValues(alpha: 0.15)
            : const Color(0xFFFFEDD5),
        textColor: isDark ? const Color(0xFFFFB86C) : const Color(0xFF9A3412),
      );
  }
}
