import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';

abstract class AbstractAutocompleteRepository {
  Future<List<CitySuggestion>> getSuggestions(String query, String langCode);
}
