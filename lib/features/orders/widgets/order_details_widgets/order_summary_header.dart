import 'package:flutter/material.dart';
import 'package:transit_tracer/core/utils/formatters/num_utils.dart';
import 'package:transit_tracer/core/utils/formatters/string_utils.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/presentation/order_status/order_status_ui_model.dart';

class OrderSummaryHeader extends StatelessWidget {
  const OrderSummaryHeader({
    super.key,
    required this.theme,
    required this.orderStatus,
    required this.order,
  });

  final ThemeData theme;
  final OrderStatusUiModel orderStatus;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final String currentLanguage = Localizations.localeOf(context).languageCode;
    return BaseContainer(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: orderStatus.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(orderStatus.lable),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: cityCutter(
                        (order.from.localizedNames[currentLanguage] ?? '')
                                .isEmpty
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
            ],
          ),
          const Divider(),
          Text(
            '₴ ${NumUtils().priceFormater(order.price)}',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
