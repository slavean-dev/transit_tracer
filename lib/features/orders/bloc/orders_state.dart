part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrderSavedSuccessfull extends OrdersState {}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded({required this.orders});
  final List<OrderData> orders;

  @override
  List<List<OrderData>> get props => [orders];
}

class OrdersEmpty extends OrdersState {}

class OrderFailure extends OrdersState {
  const OrderFailure({required this.exception});
  final String exception;

  @override
  List<String> get props => [exception];
}

class OrderDeletedSuccessfull extends OrdersState {}
