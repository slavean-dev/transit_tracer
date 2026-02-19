import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/common/order_card/order_card.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.isArchived = false});

  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) {
        if (isArchived) {
          return current is ArchiveOrdersLoaded ||
              current is ArchiveOrdersLoading ||
              current is ArchiveOrdersEmpty ||
              current is OrderFailure;
        } else {
          return current is ActiveOrdersLoaded ||
              current is ActiveOrdersLoading ||
              current is ActiveOrdersEmpty ||
              current is OrderFailure;
        }
      },
      builder: (context, state) {
        return switch (state) {
          OrdersInitial() || ActiveOrdersLoading() || ArchiveOrdersLoading() =>
            const Center(child: CircularProgressIndicator()),
          ActiveOrdersLoaded(orders: final orders) ||
          ArchiveOrdersLoaded(orders: final orders) => ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == orders.length - 1
                    ? const EdgeInsets.only(bottom: 16)
                    : EdgeInsets.zero,
                child: OrderCard(theme: theme, order: orders[index]),
              );
            },
          ),
          ActiveOrdersEmpty() || ArchiveOrdersEmpty() => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 100,
                  color: theme.iconTheme.color?.withValues(alpha: 0.5),
                ),
                Text(
                  state is ActiveOrdersEmpty
                      ? s.orderListEmpty
                      : s.archiveOrderListEmpty,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: BaseButton(
                    onPressed: () {
                      if (state is ActiveOrdersEmpty) {
                        context.router.replaceAll([
                          const HomeRoute(children: [AddOrderTabRouter()]),
                        ]);
                      } else {
                        context.router.replaceAll([OrdersListRoute()]);
                      }
                    },
                    text: state is ActiveOrdersEmpty
                        ? s.createTitle
                        : s.btnBackToOrdersList,
                  ),
                ),
              ],
            ),
          ),
          OrderFailure(exception: final exception) => Center(
            child: Text('Somethisg went wrong \n Log: $exception'),
          ),
          _ => const SizedBox(),
        };
      },
    );
  }
}
