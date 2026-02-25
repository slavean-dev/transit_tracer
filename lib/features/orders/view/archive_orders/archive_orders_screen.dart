import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/orders_list_view/orders_list_view.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class ArchiveOrdersScreen extends StatefulWidget {
  const ArchiveOrdersScreen({super.key});

  @override
  State<ArchiveOrdersScreen> createState() => _ArchiveOrdersScreenState();
}

class _ArchiveOrdersScreenState extends State<ArchiveOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(LoadArchivedOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).archiveTitle)),
      body: OrdersListView(isArchived: true),
    );
  }
}
