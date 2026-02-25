part of 'orders_bloc.dart';

enum OrderStateStatus { initial, loading, loaded, empty, error, success }

class OrdersState extends Equatable {
  const OrdersState({
    this.activeOrders = const [],
    this.archiveOrders = const [],
    this.ordersStatus = OrderStateStatus.initial,
    this.activeStatus = OrderStateStatus.initial,
    this.archiveStatus = OrderStateStatus.initial,
    this.type,
    this.error,
  });

  final List<OrderData> activeOrders;
  final List<OrderData> archiveOrders;
  final OrderStateStatus ordersStatus;
  final OrderStateStatus activeStatus;
  final OrderStateStatus archiveStatus;
  final FirebaseErrorType? type;
  final String? error;

  OrdersState copyWith({
    List<OrderData>? activeOrders,
    List<OrderData>? archiveOrders,
    OrderStateStatus? ordersStatus,
    OrderStateStatus? activeStatus,
    OrderStateStatus? archiveStatus,
    FirebaseErrorType? type,
    String? error,
  }) {
    return OrdersState(
      activeOrders: activeOrders ?? this.activeOrders,
      archiveOrders: archiveOrders ?? this.archiveOrders,
      ordersStatus: ordersStatus ?? this.ordersStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      archiveStatus: archiveStatus ?? this.archiveStatus,
      type: type ?? this.type,
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
    type,
    error,
  ];
}

// sealed class OrdersState extends Equatable {
//   const OrdersState();

//   @override
//   List<Object> get props => [];
// }

// final class OrdersInitial extends OrdersState {}

// class ActiveOrdersLoading extends OrdersState {}

// class ArchiveOrdersLoading extends OrdersState {}

// class OrderSavedSuccessfull extends OrdersState {}

// class ActiveOrdersLoaded extends OrdersState {
//   const ActiveOrdersLoaded({required this.orders});
//   final List<OrderData> orders;

//   @override
//   List<List<OrderData>> get props => [orders];
// }

// class ArchiveOrdersLoaded extends OrdersState {
//   const ArchiveOrdersLoaded({required this.orders});
//   final List<OrderData> orders;

//   @override
//   List<List<OrderData>> get props => [orders];
// }

// class ActiveOrdersEmpty extends OrdersState {}

// class ArchiveOrdersEmpty extends OrdersState {}

// abstract class OrdersFailure extends OrdersState {
//   const OrdersFailure({required this.type, this.message});
//   final FirebaseErrorType type;
//   final String? message;
// }

// // Конкретные реализации — пустые классы-метки
// class ActiveOrdersFailure extends OrdersFailure {
//   const ActiveOrdersFailure({required super.type, super.message});
// }

// class ArchiveOrdersFailure extends OrdersFailure {
//   const ArchiveOrdersFailure({required super.type, super.message});
// }

// class OrderActionFailure extends OrdersFailure {
//   // Для сейва, удаления и т.д.
//   const OrderActionFailure({required super.type, super.message});
// }
