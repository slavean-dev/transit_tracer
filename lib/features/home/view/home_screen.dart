import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/features/user/bloc/app_user_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<AppUserBloc>()),
        BlocProvider(create: (context) => GetIt.I<OrdersBloc>()),
      ],
      child: AutoTabsRouter(
        routes: [
          TransportSearchRoute(),
          AddOrderTabRouter(),
          OrdersListTabRouter(),
          ProfileTabRouter(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: S.of(context).bottNavBarSearch,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add),
                  label: S.of(context).create,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: S.of(context).ordersTitle,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: S.of(context).bottNavBarProfile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
