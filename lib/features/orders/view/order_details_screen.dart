import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/utils/date_time_utils.dart';
import 'package:transit_tracer/core/utils/map_launcher.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/features/orders/bloc/order_details/order_details_bloc.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/utils/order_status_mapper/order_status_mapper.dart';
import 'package:transit_tracer/features/orders/widgets/action_button/action_button.dart';
import 'package:transit_tracer/features/orders/widgets/order_route_map_preview/order_route_map_preview.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/presentation/mappers/weight_range_mapper.dart';

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
          if (state is OrderDeletedSuccessfull) {
            context.router.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Order details')),
          body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
            builder: (context, state) {
              return switch (state) {
                OrderDetailsInitial() || OrdersLoading() => OrderDetailsContent(
                  theme: theme,
                  order: initialData,
                  s: s,
                ),
                OrderDetailsLoaded(order: final order) => OrderDetailsContent(
                  theme: theme,
                  order: order,
                  s: s,
                ),
                _ => SizedBox(),
              };
            },
          ),
        ),
      ),
    );
  }
}

class OrderDetailsContent extends StatelessWidget {
  const OrderDetailsContent({
    super.key,
    required this.theme,
    required this.order,
    required this.s,
  });

  final ThemeData theme;
  final OrderData order;
  final S s;

  @override
  Widget build(BuildContext context) {
    final orderStatus = getStatusStyle(order.status, context);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              BaseContainer(
                theme: theme,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: orderStatus.backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Text(orderStatus.lable),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: cityCutter(order.from.name),
                                style: theme.textTheme.titleMedium,
                              ),
                              TextSpan(
                                text: '→',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              TextSpan(
                                text: cityCutter(order.to.name),
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      '₴ ${NumUtils().priceFormater(order.price)}',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: theme.colorScheme.surface,
                ),
                child: Column(
                  children: [
                    OrderRouteMapPreview(theme: theme, order: order),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ActionButton(
                          theme: theme,
                          lable: 'Open in map',
                          textColor: Colors.black,
                          backgroundColor: theme.primaryColor,
                          onPressed: () => openRouteInGoogleMaps(
                            fromLat: order.from.lat,
                            fromLng: order.from.lng,
                            toLat: order.to.lat,
                            toLng: order.to.lng,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              BaseContainer(
                theme: theme,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Cargo', style: theme.textTheme.titleMedium),
                    Text(
                      order.description,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),
              BaseContainer(
                theme: theme,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        //Text(order.oid)
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Created',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        Text(
                          order.createdAt.formatFullDate(
                            Localizations.localeOf(context),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weight',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        Text(WeightRangeMapper.label(s, order.weight)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        Text(
                          '₴ ${NumUtils().priceFormater(order.price)}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              BaseButton(
                onPressed: () {
                  context.router.push(EditOrderRoute(order: order));
                },
                text: 'Edit order',
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ActionButton(
                      theme: theme,
                      lable: 'Archive',
                      textColor: null,
                      backgroundColor: theme.colorScheme.surface,
                      onPressed: () {
                        context.read<OrderDetailsBloc>().add(
                          ArchiveOrder(oid: order.oid),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ActionButton(
                      lable: 'Delete',
                      theme: theme,
                      textColor: Colors.red,
                      backgroundColor: theme.colorScheme.surface,
                      onPressed: () {
                        final blocContext = context.read<OrderDetailsBloc>();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete order'),
                            content: const Text(
                              'Are you sure you want to delete this order?\n'
                              'This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  blocContext.add(
                                    DeleteUserOrder(oid: order.oid),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
