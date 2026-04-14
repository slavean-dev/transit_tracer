part of 'orders_list_bloc.dart';

class OrdersListState extends Equatable {
  const OrdersListState();

  @override
  List<Object> get props => [];
}

class OrdersListInitial extends OrdersListState {}

class OrdersListLoading extends OrdersListState {}

class OrderListEmpty extends OrdersListState {}

class OrdersListLoaded extends OrdersListState {
  final List<OrderData> orders;

  const OrdersListLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrdersListError extends OrdersListState {
  final String? error;
  final FirebaseErrorType? firebaseType;

  const OrdersListError({this.error, this.firebaseType});

  @override
  List<Object> get props => [
    error ?? '',
    firebaseType ?? FirebaseErrorType.unknown,
  ];
}
