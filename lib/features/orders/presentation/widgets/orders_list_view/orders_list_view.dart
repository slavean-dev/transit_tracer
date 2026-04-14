import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/common/order_card/order_card.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});

  final List<OrderData> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: index == orders.length - 1
              ? const EdgeInsets.only(bottom: 16)
              : EdgeInsets.zero,
          child: OrderCard(order: orders[index]),
        );
      },
    );
    // return BlocListener<OrdersBloc, OrdersState>(
    //   listenWhen: (previous, current) {
    //     final prevStatus = isArchived
    //         ? previous.archiveStatus
    //         : previous.activeStatus;
    //     final currStatus = isArchived
    //         ? current.archiveStatus
    //         : current.activeStatus;

    //     return prevStatus != currStatus && currStatus == OrderStateStatus.error;
    //   },
    //   listener: (context, state) {
    //     final currentStatus = isArchived
    //         ? state.archiveStatus
    //         : state.activeStatus;
    //     if (currentStatus == OrderStateStatus.error &&
    //         state.firebaseType != null) {
    //       final error = ErrorTranslator.translate(context, state.firebaseType);
    //       if (error != null) {
    //         AppSnackBar.showErrorMessage(context, error);
    //       }
    //     }
    //   },
    //   child: BlocBuilder<OrdersBloc, OrdersState>(
    //     buildWhen: (previous, current) {
    //       final prevStatus = isArchived
    //           ? previous.archiveStatus
    //           : previous.activeStatus;
    //       final currStatus = isArchived
    //           ? current.archiveStatus
    //           : current.activeStatus;
    //       final currOrders = isArchived
    //           ? current.archiveOrders
    //           : current.activeOrders;

    //       if (prevStatus == currStatus &&
    //           (isArchived
    //               ? previous.archiveOrders == current.archiveOrders
    //               : previous.activeOrders == current.activeOrders)) {
    //         return false;
    //       }

    //       if (currStatus == OrderStateStatus.error && currOrders.isNotEmpty) {
    //         return false;
    //       }

    //       return true;
    //     },
    //     builder: (context, state) {
    //       return switch (state) {
    //         OrdersState st
    //             when (isArchived ? st.archiveStatus : st.activeStatus) ==
    //                 OrderStateStatus.loaded =>
    //           ListView.builder(
    //             itemCount: isArchived
    //                 ? st.archiveOrders.length
    //                 : st.activeOrders.length,
    //             itemBuilder: (context, index) {
    //               final orders = isArchived
    //                   ? st.archiveOrders
    //                   : st.activeOrders;
    //               return Padding(
    //                 padding: index == orders.length - 1
    //                     ? const EdgeInsets.only(bottom: 16)
    //                     : EdgeInsets.zero,
    //                 child: OrderCard(theme: theme, order: orders[index]),
    //               );
    //             },
    //           ),
    //         OrdersState st
    //             when (isArchived ? st.archiveStatus : st.activeStatus) ==
    //                 OrderStateStatus.error =>
    //           OrdersListErrorWidget(isArchived: isArchived),
    //         OrdersState st
    //             when (isArchived ? st.archiveStatus : st.activeStatus) ==
    //                 OrderStateStatus.loading =>
    //           const Center(child: CircularProgressIndicator()),
    //         OrdersState st
    //             when (isArchived ? st.archiveStatus : st.activeStatus) ==
    //                 OrderStateStatus.empty =>
    //           OrderListEmptyWidget(isArchived: isArchived, isOnline: isOnline),
    //         _ => const SizedBox(),
    //       };
    //     },
    //   ),
    // );
  }
}
