import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderListEmptyWidget extends StatelessWidget {
  const OrderListEmptyWidget({
    super.key,
    required this.isArchived,
    required this.isOnline,
  });
  final bool isArchived;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 100,
            color: theme.iconTheme.color?.withValues(alpha: 0.5),
          ),
          Text(!isArchived ? s.orderListEmpty : s.archiveOrderListEmpty),
          isOnline
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: 16,
                        color: theme.hintColor,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            s.orderListOfline,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.hintColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: BaseButton(
              onPressed: () {
                if (!isArchived) {
                  context.router.replaceAll([
                    const HomeRoute(children: [AddOrderTabRouter()]),
                  ]);
                } else {
                  context.router.replaceAll([OrdersListRoute()]);
                }
              },
              text: !isArchived ? s.createTitle : s.btnBackToOrdersList,
            ),
          ),
        ],
      ),
    );
  }
}
