part of 'edit_order_bloc.dart';

class EditOrderEvent extends Equatable {
  const EditOrderEvent();

  @override
  List<Object> get props => [];
}

class EditOrderData extends EditOrderEvent {
  const EditOrderData({
    required this.oldFrom,
    required this.oldTo,
    required this.fromSuggestion,
    required this.toSuggestion,
    required this.description,
    required this.weight,
    required this.price,
    required this.uid,
    required this.oid,
    required this.status,
    required this.createdAt,
  });

  final CityPoint oldFrom;
  final CityPoint oldTo;
  final CitySuggestion fromSuggestion;
  final CitySuggestion toSuggestion;
  final String description;
  final WeightRange weight;
  final String price;
  final String uid;
  final String oid;
  final OrderStatus status;
  final DateTime createdAt;

  @override
  List<Object> get props => [
    oldFrom,
    oldTo,
    fromSuggestion,
    toSuggestion,
    description,
    weight,
    price,
    uid,
    oid,
    status,
    createdAt,
  ];
}
