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

class EditOrderData extends OrderDetailsEvent {
  const EditOrderData({
    required this.from,
    required this.to,
    required this.description,
    required this.weight,
    required this.price,
    required this.uid,
    required this.oid,
    required this.status,
    required this.createdAt,
  });

  final CityPoint from;
  final CityPoint to;
  final String description;
  final WeightRange weight;
  final String price;
  final String uid;
  final String oid;
  final OrderStatus status;
  final DateTime createdAt;

  @override
  List<Object> get props => [
    from,
    to,
    description,
    weight,
    price,
    uid,
    oid,
    status,
    createdAt,
  ];
}

class ToggleArchiveStatus extends OrderDetailsEvent {
  const ToggleArchiveStatus({required this.order});

  final OrderData order;

  @override
  List<OrderData> get props => [order];
}
