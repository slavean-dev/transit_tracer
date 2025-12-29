import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';

class OrderFormData {
  OrderFormData({
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
}
