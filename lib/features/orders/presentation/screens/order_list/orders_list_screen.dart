import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/utils/ui/app_snack_bar.dart';
import 'package:transit_tracer/features/orders/presentation/screens/order_list/bloc/orders_list_bloc.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_empty/orders_list_empty.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_error/orders_list_error.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/orders_list_view/orders_list_view.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  @override
  Widget build(BuildContext context) {
    final isOnline = context.select((SettingsCubit c) => c.state.isOnline);
    return BlocProvider(
      create: (context) => GetIt.I<OrdersListBloc>()..add(LoadUserOrders()),
      child: BlocListener<OrdersListBloc, OrdersListState>(
        listener: (context, state) {
          if (state is OrdersListError) {
            final error = ErrorTranslator.translate(
              context,
              state.firebaseType,
            );
            if (error != null) {
              AppSnackBar.showErrorMessage(context, error);
            }
          }
        },
        child: Scaffold(
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
          body: BlocBuilder<OrdersListBloc, OrdersListState>(
            builder: (context, state) {
              switch (state) {
                case OrdersListLoading():
                  return const Center(child: CircularProgressIndicator());
                case OrderListEmpty():
                  return OrderListEmptyWidget(
                    isArchived: false,
                    isOnline: isOnline,
                  );
                case OrdersListLoaded():
                  return OrdersListView(orders: state.orders);
                case OrdersListError():
                  return const OrdersListErrorWidget(isArchived: false);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
