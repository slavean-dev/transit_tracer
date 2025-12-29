part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadUserOrders extends OrdersEvent {}

class SaveUserOrder extends OrdersEvent {
  const SaveUserOrder({
    required this.from,
    required this.to,
    required this.discription,
    required this.weight,
    required this.price,
  });
  final CityPoint from;
  final CityPoint to;
  final String discription;
  final WeightRange weight;
  final String price;

  @override
  List<Object> get props => [from, to, discription, weight, price];
}

class DeleteUserOrder extends OrdersEvent {
  const DeleteUserOrder({required this.oid});
  final String oid;

  @override
  List<String> get props => [oid];
}
