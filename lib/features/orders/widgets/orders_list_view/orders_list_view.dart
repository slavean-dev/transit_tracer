import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/common/order_card/order_card.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.isArchived = false});

  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          ActiveOrdersEmpty() || ArchiveOrdersEmpty() => const Center(
            child: Text('You don`t have orders'),
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
