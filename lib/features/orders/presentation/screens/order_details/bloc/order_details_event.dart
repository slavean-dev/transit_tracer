part of 'order_details_bloc.dart';

sealed class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserOrder extends OrderDetailsEvent {
  const DeleteUserOrder({required this.oid});
  final String oid;

  @override
  List<String> get props => [oid];
}

class LoadOrderDetails extends OrderDetailsEvent {
  const LoadOrderDetails({required this.oid});

  final String oid;

  @override
  List<String> get props => [oid];
}

class ToggleArchiveStatus extends OrderDetailsEvent {
  const ToggleArchiveStatus({required this.order});

  final OrderData order;

  @override
  List<OrderData> get props => [order];
}
