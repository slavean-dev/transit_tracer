import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/utils/date_time_utils.dart';
import 'package:transit_tracer/core/utils/map_launcher.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/widgets/action_button/action_button.dart';
import 'package:transit_tracer/features/orders/widgets/order_route_map_preview/order_route_map_preview.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/presentation/mappers/weight_range_mapper.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is OrderDeletedSuccessfull) {
          context.router.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Order details')),
        body: SingleChildScrollView(
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
                            color: const Color(0xFF3D4B3F),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Text('Active'),
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
                          order.discription,
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
                  BaseButton(onPressed: () {}, text: 'Respond'),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ActionButton(
                          theme: theme,
                          lable: 'Edit',
                          textColor: Colors.white,
                          backgroundColor: theme.colorScheme.surface,
                          onPressed: () {
                            context.router.push(EditOrderRoute(order: order));
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
                            final blocContext = context.read<OrdersBloc>();
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
        ),
      ),
    );
  }
}
