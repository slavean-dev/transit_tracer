import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';

class AutocompleteValidate {
  static String? city(
    String? v,
    CitySuggestion? suggestion, {
    String fieldName = 'City',
  }) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return '$fieldName is required';
    if (suggestion == null) return 'Select from suggestions';
    if (value.length < 2) return '$fieldName is too short';
    return null;
  }
}
