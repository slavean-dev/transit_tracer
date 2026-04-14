import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/orders/presentation/screens/archive_orders/bloc/archive_orders_bloc.dart';
import 'package:transit_tracer/features/orders/presentation/screens/order_list/bloc/orders_list_bloc.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrdersListErrorWidget extends StatelessWidget {
  const OrdersListErrorWidget({super.key, required this.isArchived});

  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sentiment_dissatisfied,
            size: 70,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(s.ordersListErrorTitle),
          const SizedBox(height: 8),
          Text(
            s.ordersListErrorMessage,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 13),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              if (!isArchived) {
                context.read<OrdersListBloc>().add(LoadUserOrders());
              } else {
                context.read<ArchiveOrdersBloc>().add(LoadArchivedOrders());
              }
            },

            icon: const Icon(Icons.refresh),
            label: Text(s.btnTryAgain),
          ),
        ],
      ),
    );
  }
}
