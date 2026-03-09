import 'package:dio/dio.dart';

class GeoApiService {
  GeoApiService(this.apiKey);
  final String apiKey;
  final Dio _dio = Dio();

  Future<Response<dynamic>> searchCities({
    required String query,
    required String langCode,
    int? limit,
  }) async {
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final response = await _dio.get(
      url,
      queryParameters: {
        'input': query,
        'types': '(cities)',
        'language': langCode,
        'components': 'country:ua',
        'limit': limit,
        'key': apiKey,
      },
    );

    return response;
  }

  Future<Response<dynamic>> getPlaceDetails(
    String placeId,
    String langCode,
  ) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json';
    final response = await _dio.get(
      url,
      queryParameters: {
        'place_id': placeId,
        'fields': 'name,geometry,address_components',
        'language': langCode,
        'key': apiKey,
      },
    );

    return response;
  }
}
