part of 'create_order_bloc.dart';

class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class SaveUserOrder extends CreateOrderEvent {
  const SaveUserOrder({
    required this.from,
    required this.to,
    required this.description,
    required this.weight,
    required this.price,
  });
  final CitySuggestion from;
  final CitySuggestion to;
  final String description;
  final WeightRange weight;
  final String price;

  @override
  List<Object> get props => [from, to, description, weight, price];
}
