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
    required this.description,
    required this.weight,
    required this.price,
  });
  final CityPoint from;
  final CityPoint to;
  final String description;
  final WeightRange weight;
  final String price;

  @override
  List<Object> get props => [from, to, description, weight, price];
}
