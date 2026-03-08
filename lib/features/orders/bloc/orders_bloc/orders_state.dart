part of 'orders_bloc.dart';

enum OrderStateStatus { initial, loading, loaded, empty, error, success }

class OrdersState extends Equatable {
  const OrdersState({
    this.activeOrders = const [],
    this.archiveOrders = const [],
    this.ordersStatus = OrderStateStatus.initial,
    this.activeStatus = OrderStateStatus.initial,
    this.archiveStatus = OrderStateStatus.initial,
    this.firebaseType,
    this.geoType,
    this.error,
  });

  final List<OrderData> activeOrders;
  final List<OrderData> archiveOrders;
  final OrderStateStatus ordersStatus;
  final OrderStateStatus activeStatus;
  final OrderStateStatus archiveStatus;
  final FirebaseErrorType? firebaseType;
  final GeoErrorType? geoType;
  final String? error;

  OrdersState copyWith({
    List<OrderData>? activeOrders,
    List<OrderData>? archiveOrders,
    OrderStateStatus? ordersStatus,
    OrderStateStatus? activeStatus,
    OrderStateStatus? archiveStatus,
    FirebaseErrorType? firebaseType,
    GeoErrorType? geoType,
    String? error,
  }) {
    return OrdersState(
      activeOrders: activeOrders ?? this.activeOrders,
      archiveOrders: archiveOrders ?? this.archiveOrders,
      ordersStatus: ordersStatus ?? this.ordersStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      archiveStatus: archiveStatus ?? this.archiveStatus,
      firebaseType: firebaseType ?? firebaseType,
      geoType: geoType ?? geoType,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    activeOrders,
    archiveOrders,
    ordersStatus,
    activeStatus,
    archiveStatus,
    firebaseType,
    geoType,
    error,
  ];
}
