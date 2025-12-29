import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/app/ui/widgets/base_container.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.theme, required this.order});

  final OrderData order;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
      child: GestureDetector(
        onTap: () => context.router.push(OrderDetailsRoute(order: order)),
        child: BaseContainer(
          theme: theme,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: cityCutter(order.from.name),
                        style: theme.textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: '→',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: cityCutter(order.to.name),
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cargo:'),
                          Text(
                            order.discription,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '₴ ${NumUtils().priceFormater(order.price)}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          child: Text(
                            'More ›',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
