import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';

class OrderFormData {
  OrderFormData(
    this.uid,
    this.oid,
    this.isActive,
    this.createdAt, {
    required this.fromSuggestion,
    required this.toSuggestion,
    required this.description,
    required this.weight,
    required this.price,
  });
  final CitySuggestion fromSuggestion;
  final CitySuggestion toSuggestion;

  final String description;
  final WeightRange weight;
  final String price;
  final String? uid;
  final String? oid;
  final OrderStatus? isActive;
  final DateTime? createdAt;
}
