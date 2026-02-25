import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/utils/ui/app_snack_bar.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/common/order_card/order_card.dart';
import 'package:transit_tracer/features/orders/widgets/orders_list_view/orders_list_empty/orders_list_empty.dart';
import 'package:transit_tracer/features/orders/widgets/orders_list_view/orders_list_error/orders_list_error.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.isArchived = false});

  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOnline = context.select((SettingsCubit c) => c.state.isOnline);
    return BlocListener<OrdersBloc, OrdersState>(
      listenWhen: (previous, current) {
        final prevStatus = isArchived
            ? previous.archiveStatus
            : previous.activeStatus;
        final currStatus = isArchived
            ? current.archiveStatus
            : current.activeStatus;

        return prevStatus != currStatus && currStatus == OrderStateStatus.error;
      },
      listener: (context, state) {
        final currentStatus = isArchived
            ? state.archiveStatus
            : state.activeStatus;
        if (currentStatus == OrderStateStatus.error && state.type != null) {
          final error = ErrorTranslator.translate(context, state.type);
          if (error != null) {
            AppSnackBar.showErrorMessage(context, error);
          }
        }
      },
      child: BlocBuilder<OrdersBloc, OrdersState>(
        buildWhen: (previous, current) {
          final prevStatus = isArchived
              ? previous.archiveStatus
              : previous.activeStatus;
          final currStatus = isArchived
              ? current.archiveStatus
              : current.activeStatus;
          final currOrders = isArchived
              ? current.archiveOrders
              : current.activeOrders;

          if (prevStatus == currStatus &&
              (isArchived
                  ? previous.archiveOrders == current.archiveOrders
                  : previous.activeOrders == current.activeOrders)) {
            return false;
          }

          if (currStatus == OrderStateStatus.error && currOrders.isNotEmpty) {
            return false;
          }

          return true;
        },
        builder: (context, state) {
          return switch (state) {
            OrdersState st
                when (isArchived ? st.archiveStatus : st.activeStatus) ==
                    OrderStateStatus.loaded =>
              ListView.builder(
                itemCount: isArchived
                    ? st.archiveOrders.length
                    : st.activeOrders.length,
                itemBuilder: (context, index) {
                  final orders = isArchived
                      ? st.archiveOrders
                      : st.activeOrders;
                  return Padding(
                    padding: index == orders.length - 1
                        ? const EdgeInsets.only(bottom: 16)
                        : EdgeInsets.zero,
                    child: OrderCard(theme: theme, order: orders[index]),
                  );
                },
              ),
            OrdersState st
                when (isArchived ? st.archiveStatus : st.activeStatus) ==
                    OrderStateStatus.error =>
              OrdersListErrorWidget(isArchived: isArchived),
            OrdersState st
                when (isArchived ? st.archiveStatus : st.activeStatus) ==
                    OrderStateStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            OrdersState st
                when (isArchived ? st.archiveStatus : st.activeStatus) ==
                    OrderStateStatus.empty =>
              OrderListEmptyWidget(isArchived: isArchived, isOnline: isOnline),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
