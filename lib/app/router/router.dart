import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/features/about_us/view/about_us_screen.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/tabs/add_order_tab_page.dart';
import 'package:transit_tracer/features/orders/view/create_order_screen.dart';
import 'package:transit_tracer/features/orders/view/archive_orders_screen.dart';
import 'package:transit_tracer/features/auth/auth_gate/auth_gate.dart';
import 'package:transit_tracer/features/orders/tabs/orders_list_tab_page.dart';
import 'package:transit_tracer/features/orders/view/edit_order_screen.dart';
import 'package:transit_tracer/features/orders/view/order_details_screen.dart';
import 'package:transit_tracer/features/orders/view/orders_list_screen.dart';
import 'package:transit_tracer/features/transports/view/transport_results_screen.dart';

import 'package:transit_tracer/features/transports/tabs/transport_search_tab_router.dart';
import 'package:transit_tracer/features/auth/view/auth_screen.dart';
import 'package:transit_tracer/features/home/view/home_screen.dart';
import 'package:transit_tracer/features/profile/tabs/profile_tab_router.dart';
import 'package:transit_tracer/features/profile/view/profile_screen.dart';
import 'package:transit_tracer/features/settings/settings_screen/settings_screen.dart';
import 'package:transit_tracer/features/transports/view/transport_search_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthGateRoute.page,
      initial: true,
      path: '/',
      children: [
        AutoRoute(page: AuthRoute.page, path: 'auth'),
        AutoRoute(
          page: HomeRoute.page,
          path: 'home',
          children: [
            AutoRoute(
              page: TransportSearchTabRouter.page,
              path: 'search',
              children: [
                AutoRoute(
                  page: TransportSearchRoute.page,
                  path: '',
                  initial: true,
                ),
                AutoRoute(page: TransportResultsRoute.page, path: 'results'),
              ],
            ),

            AutoRoute(
              page: AddOrderTabRouter.page,
              path: 'createOrder',
              children: [AutoRoute(page: CreateOrderRoute.page, path: '')],
            ),

            AutoRoute(
              page: OrdersListTabRouter.page,
              path: 'orders',
              children: [
                AutoRoute(page: OrdersListRoute.page, path: '', initial: true),
                AutoRoute(page: OrderDetailsRoute.page, path: 'details'),
                AutoRoute(page: EditOrderRoute.page, path: 'edit'),
                AutoRoute(page: ArchiveOrdersRoute.page, path: 'archive'),
              ],
            ),

            AutoRoute(
              page: ProfileTabRouter.page,
              path: 'profile',
              children: [
                AutoRoute(page: ProfileRoute.page, path: '', initial: true),
              ],
            ),
          ],
        ),
      ],
    ),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    AutoRoute(page: AboutUsRoute.page, path: '/about'),
  ];
}
