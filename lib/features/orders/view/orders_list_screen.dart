import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/order_card/order_card.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(LoadUserOrders());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ordersTitle),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const ArchiveOrdersRoute());
            },
            icon: const Icon(Icons.archive),
          ),
        ],
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        buildWhen: (previous, current) {
          return current is OrdersLoading ||
              current is OrdersLoaded ||
              current is OrdersEmpty ||
              current is OrderFailure;
        },
        builder: (context, state) {
          return switch (state) {
            OrdersInitial() ||
            OrdersLoading() => const Center(child: CircularProgressIndicator()),
            OrdersLoaded(orders: final orders) => ListView.builder(
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
            OrdersEmpty() => const Center(child: Text('You don`t have orders')),
            OrderFailure(exception: final exception) => Center(
              child: Text('Somethisg went wrong \n Log: $exception'),
            ),
            _ => const SizedBox(),
          };
          // if (state is OrdersLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // } else if (state is OrdersLoaded) {
          //   final orders = state.orders;
          //   return
          // } else if (state is OrdersEmpty) {
          //   return const Center(child: Text('You don`t have orders'));
          // } else {
          //   return const Center(child: Text('Somethisg went wrong'));
          // }
        },
      ),
    );
  }
}
