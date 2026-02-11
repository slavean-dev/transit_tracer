part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

class ActiveOrdersLoading extends OrdersState {}

class ArchiveOrdersLoading extends OrdersState {}

class OrderSavedSuccessfull extends OrdersState {}

class ActiveOrdersLoaded extends OrdersState {
  const ActiveOrdersLoaded({required this.orders});
  final List<OrderData> orders;

  @override
  List<List<OrderData>> get props => [orders];
}

class ArchiveOrdersLoaded extends OrdersState {
  const ArchiveOrdersLoaded({required this.orders});
  final List<OrderData> orders;

  @override
  List<List<OrderData>> get props => [orders];
}

class ActiveOrdersEmpty extends OrdersState {}

class ArchiveOrdersEmpty extends OrdersState {}

class OrderFailure extends OrdersState {
  const OrderFailure({required this.exception});
  final String exception;

  @override
  List<String> get props => [exception];
}
