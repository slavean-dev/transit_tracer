// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AboutUsScreen]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute({List<PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutUsScreen();
    },
  );
}

/// generated route for
/// [AddOrderTabPage]
class AddOrderTabRouter extends PageRouteInfo<void> {
  const AddOrderTabRouter({List<PageRouteInfo>? children})
    : super(AddOrderTabRouter.name, initialChildren: children);

  static const String name = 'AddOrderTabRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddOrderTabPage();
    },
  );
}

/// generated route for
/// [ArchiveOrdersScreen]
class ArchiveOrdersRoute extends PageRouteInfo<void> {
  const ArchiveOrdersRoute({List<PageRouteInfo>? children})
    : super(ArchiveOrdersRoute.name, initialChildren: children);

  static const String name = 'ArchiveOrdersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ArchiveOrdersScreen();
    },
  );
}

/// generated route for
/// [AuthGate]
class AuthGateRoute extends PageRouteInfo<void> {
  const AuthGateRoute({List<PageRouteInfo>? children})
    : super(AuthGateRoute.name, initialChildren: children);

  static const String name = 'AuthGateRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthGate();
    },
  );
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [CreateOrderScreen]
class CreateOrderRoute extends PageRouteInfo<void> {
  const CreateOrderRoute({List<PageRouteInfo>? children})
    : super(CreateOrderRoute.name, initialChildren: children);

  static const String name = 'CreateOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return CreateOrderScreen();
    },
  );
}

/// generated route for
/// [EditOrderScreen]
class EditOrderRoute extends PageRouteInfo<EditOrderRouteArgs> {
  EditOrderRoute({
    Key? key,
    required OrderData order,
    List<PageRouteInfo>? children,
  }) : super(
         EditOrderRoute.name,
         args: EditOrderRouteArgs(key: key, order: order),
         initialChildren: children,
       );

  static const String name = 'EditOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditOrderRouteArgs>();
      return EditOrderScreen(key: args.key, order: args.order);
    },
  );
}

class EditOrderRouteArgs {
  const EditOrderRouteArgs({this.key, required this.order});

  final Key? key;

  final OrderData order;

  @override
  String toString() {
    return 'EditOrderRouteArgs{key: $key, order: $order}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditOrderRouteArgs) return false;
    return key == other.key && order == other.order;
  }

  @override
  int get hashCode => key.hashCode ^ order.hashCode;
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [OrderDetailsScreen]
class OrderDetailsRoute extends PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    Key? key,
    required OrderData order,
    List<PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(key: key, order: order),
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>();
      return OrderDetailsScreen(key: args.key, order: args.order);
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.order});

  final Key? key;

  final OrderData order;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, order: $order}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderDetailsRouteArgs) return false;
    return key == other.key && order == other.order;
  }

  @override
  int get hashCode => key.hashCode ^ order.hashCode;
}

/// generated route for
/// [OrdersListScreen]
class OrdersListRoute extends PageRouteInfo<void> {
  const OrdersListRoute({List<PageRouteInfo>? children})
    : super(OrdersListRoute.name, initialChildren: children);

  static const String name = 'OrdersListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrdersListScreen();
    },
  );
}

/// generated route for
/// [OrdersListTabPage]
class OrdersListTabRouter extends PageRouteInfo<void> {
  const OrdersListTabRouter({List<PageRouteInfo>? children})
    : super(OrdersListTabRouter.name, initialChildren: children);

  static const String name = 'OrdersListTabRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrdersListTabPage();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [ProfileTabPage]
class ProfileTabRouter extends PageRouteInfo<void> {
  const ProfileTabRouter({List<PageRouteInfo>? children})
    : super(ProfileTabRouter.name, initialChildren: children);

  static const String name = 'ProfileTabRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileTabPage();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [TransportResultsScreen]
class TransportResultsRoute extends PageRouteInfo<TransportResultsRouteArgs> {
  TransportResultsRoute({
    Key? key,
    required String frome,
    required String to,
    required String date,
    List<PageRouteInfo>? children,
  }) : super(
         TransportResultsRoute.name,
         args: TransportResultsRouteArgs(
           key: key,
           frome: frome,
           to: to,
           date: date,
         ),
         initialChildren: children,
       );

  static const String name = 'TransportResultsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransportResultsRouteArgs>();
      return TransportResultsScreen(
        key: args.key,
        frome: args.frome,
        to: args.to,
        date: args.date,
      );
    },
  );
}

class TransportResultsRouteArgs {
  const TransportResultsRouteArgs({
    this.key,
    required this.frome,
    required this.to,
    required this.date,
  });

  final Key? key;

  final String frome;

  final String to;

  final String date;

  @override
  String toString() {
    return 'TransportResultsRouteArgs{key: $key, frome: $frome, to: $to, date: $date}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransportResultsRouteArgs) return false;
    return key == other.key &&
        frome == other.frome &&
        to == other.to &&
        date == other.date;
  }

  @override
  int get hashCode =>
      key.hashCode ^ frome.hashCode ^ to.hashCode ^ date.hashCode;
}

/// generated route for
/// [TransportSearchPage]
class TransportSearchRoute extends PageRouteInfo<void> {
  const TransportSearchRoute({List<PageRouteInfo>? children})
    : super(TransportSearchRoute.name, initialChildren: children);

  static const String name = 'TransportSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransportSearchPage();
    },
  );
}

/// generated route for
/// [TransportSearchTabPage]
class TransportSearchTabRouter extends PageRouteInfo<void> {
  const TransportSearchTabRouter({List<PageRouteInfo>? children})
    : super(TransportSearchTabRouter.name, initialChildren: children);

  static const String name = 'TransportSearchTabRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransportSearchTabPage();
    },
  );
}
