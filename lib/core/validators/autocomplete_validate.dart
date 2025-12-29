import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';

class AutocompleteValidate {
  static String? city(
    String? v,
    CityPoint? placeId, {
    String fieldName = 'City',
  }) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return '$fieldName is required';
    if (placeId == null) return 'Select from suggestions';
    if (value.length < 2) return '$fieldName is too short';
    return null;
  }
}
