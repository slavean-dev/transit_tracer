import 'package:transit_tracer/core/services/geo_api_service/geo_api_service.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/city_autocomplete/data/repository/abstract_autocomplete_repository.dart';

class AutocompleteRepository implements AbstractAutocompleteRepository {
  const AutocompleteRepository({required this.geoService});
  final GeoApiService geoService;

  @override
  Future<List<CitySuggestion>> getSuggestions(
    String query,
    String langCode,
  ) async {
    try {
      final response = await geoService.searchCities(
        query: query,
        langCode: langCode,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List predictions = data['predictions'] ?? [];
        return predictions.map((e) => CitySuggestion.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
