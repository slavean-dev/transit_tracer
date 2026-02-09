import 'package:flutter/material.dart';
import 'package:transit_tracer/core/utils/date_time_utils.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/presentation/mappers/weight_range_mapper.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key, required this.theme, required this.order});

  final ThemeData theme;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BaseContainer(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.orderIdLabel,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.hintColor,
                ),
              ),
              //Text(order.oid)
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.orderCreatedDateLabel,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.hintColor,
                ),
              ),
              Text(
                order.createdAt.formatFullDate(Localizations.localeOf(context)),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.orderWeightLabel,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.hintColor,
                ),
              ),
              Text(WeightRangeMapper.label(s, order.weight)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.orderPriceLabel,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.hintColor,
                ),
              ),
              Text(
                '₴ ${NumUtils().priceFormater(order.price)}',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
