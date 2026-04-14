import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/features/orders/presentation/screens/archive_orders/bloc/archive_orders_bloc.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_empty/orders_list_empty.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_error/orders_list_error.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_view.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class ArchiveOrdersScreen extends StatefulWidget {
  const ArchiveOrdersScreen({super.key});

  @override
  State<ArchiveOrdersScreen> createState() => _ArchiveOrdersScreenState();
}

class _ArchiveOrdersScreenState extends State<ArchiveOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final isOnline = context.select((SettingsCubit c) => c.state.isOnline);
    return BlocProvider(
      create: (context) =>
          GetIt.I<ArchiveOrdersBloc>()..add(LoadArchivedOrders()),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).archiveTitle)),
        body: BlocBuilder<ArchiveOrdersBloc, ArchiveOrdersState>(
          builder: (context, state) {
            switch (state) {
              case ArchiveOrdersLoading():
                return const Center(child: CircularProgressIndicator());
              case ArchiveOrdersEmpty():
                return OrderListEmptyWidget(
                  isArchived: true,
                  isOnline: isOnline,
                );
              case ArchiveOrdersLoaded():
                return OrdersListView(orders: state.orders);
              case ArchiveOrdersError():
                return OrdersListErrorWidget(isArchived: true);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
