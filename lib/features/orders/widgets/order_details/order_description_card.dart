import 'package:flutter/material.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderDescriptionCard extends StatelessWidget {
  const OrderDescriptionCard({
    super.key,
    required this.theme,
    required this.order,
  });

  final ThemeData theme;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BaseContainer(
      theme: theme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(s.orderCargoTitle, style: theme.textTheme.titleMedium),
          Text(
            order.description,
            style: theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}
