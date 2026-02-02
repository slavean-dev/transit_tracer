import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/utils/order_status_mapper/order_status_mapper.dart';
import 'package:transit_tracer/features/orders/view/order_details/widgets/order_action_section.dart';
import 'package:transit_tracer/features/orders/view/order_details/widgets/order_description_card.dart';
import 'package:transit_tracer/features/orders/view/order_details/widgets/order_info_card.dart';
import 'package:transit_tracer/features/orders/view/order_details/widgets/order_map_card.dart';
import 'package:transit_tracer/features/orders/view/order_details/widgets/order_summary_header.dart';

class OrderDetailsContent extends StatelessWidget {
  const OrderDetailsContent({
    super.key,
    required this.theme,
    required this.order,
  });

  final ThemeData theme;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final orderStatus = getStatusStyle(order.status, context);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              OrderSummaryHeader(
                theme: theme,
                orderStatus: orderStatus,
                order: order,
              ),
              SizedBox(height: 12),
              OrderMapCard(theme: theme, order: order),
              SizedBox(height: 12),
              OrderDescriptionCard(theme: theme, order: order),

              SizedBox(height: 12),
              OrderInfoCard(theme: theme, order: order),
              SizedBox(height: 8),
              OrderActionSection(order: order, theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}
