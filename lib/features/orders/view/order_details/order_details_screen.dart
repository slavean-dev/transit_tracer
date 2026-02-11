import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/features/orders/bloc/order_details/order_details_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/view/order_details/order_details_content.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.oid,
    required this.initialData,
  });

  final String oid;
  final OrderData initialData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return BlocProvider(
      create: (context) =>
          GetIt.I<OrderDetailsBloc>()..add(LoadOrderDetails(oid: oid)),
      child: BlocListener<OrderDetailsBloc, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDeletedSuccessfull ||
              state is OrderArchiveSuccessfull) {
            context.router.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(s.orderDetailsTitle)),
          body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
            builder: (context, state) {
              return switch (state) {
                OrderDetailsInitial() || OrderDetailsLoading() =>
                  OrderDetailsContent(theme: theme, order: initialData),
                OrderDetailsLoaded(order: final order) => OrderDetailsContent(
                  theme: theme,
                  order: order,
                ),
                _ => const SizedBox(),
              };
            },
          ),
        ),
      ),
    );
  }
}
