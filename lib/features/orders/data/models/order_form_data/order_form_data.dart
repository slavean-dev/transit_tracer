import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';

class OrderFormData {
  OrderFormData(
    this.uid,
    this.oid,
    this.isActive,
    this.createdAt, {
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
  final String? uid;
  final String? oid;
  final OrderStatus? isActive;
  final DateTime? createdAt;
}
