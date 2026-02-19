import 'package:flutter/material.dart';
import 'package:transit_tracer/core/utils/formatters/string_utils.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderCardHeader extends StatelessWidget {
  const OrderCardHeader({super.key, required this.order});
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final String currentLanguage = Localizations.localeOf(context).languageCode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: cityCutter(
                    (order.from.localizedNames[currentLanguage] ?? '').isEmpty
                        ? order.from.name
                        : order.from.localizedNames[currentLanguage]!,
                  ),
                  style: theme.textTheme.titleMedium,
                ),
                TextSpan(
                  text: '→',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                TextSpan(
                  text: cityCutter(
                    (order.to.localizedNames[currentLanguage] ?? '').isEmpty
                        ? order.to.name
                        : order.to.localizedNames[currentLanguage]!,
                  ),
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        order.isPending
            ? Tooltip(
                constraints: BoxConstraints(maxWidth: 270),
                message: s.orderSyncPendingTooltip,
                waitDuration: const Duration(milliseconds: 400),

                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                textStyle: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.cloud_upload_outlined,
                  size: 24,
                  color: theme.hintColor.withValues(alpha: 0.3),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
