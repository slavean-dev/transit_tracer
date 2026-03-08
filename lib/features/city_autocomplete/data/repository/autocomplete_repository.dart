import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_errors_to_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/services/geo_api_service/geo_api_service.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/city_autocomplete/data/repository/abstract_autocomplete_repository.dart';

class AutocompleteRepository implements AbstractAutocompleteRepository {
  const AutocompleteRepository({required this.geoService});
  final GeoApiService geoService;

  @override
  Future<List<CitySuggestion>> getSuggestions({
    required String query,
    required String langCode,
    int? limit,
  }) async {
    try {
      final response = await geoService.searchCities(
        query: query,
        langCode: langCode,
        limit: limit,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List predictions = data['predictions'] ?? [];
        return predictions.map((e) => CitySuggestion.fromJson(e)).toList();
      } else {
        throw Exception(response.data['status']);
      }
    } catch (e) {
      final type = GeoErrorsToType.map(e);
      throw GeoFailure(e.toString(), type: type);
    }
  }
}
