import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/orders_list_view/orders_list_view.dart';
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
      body: OrdersListView(),
    );
  }
}
