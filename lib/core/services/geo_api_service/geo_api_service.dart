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

  Future<Response<dynamic>> getRoute({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'https://maps.googleapis.com/maps/api/directions/json',
      queryParameters: {
        'origin': '$fromLat,$fromLng',
        'destination': '$toLat,$toLng',
        'mode': 'driving',
        'key': apiKey,
      },
    );
    return response;
  }
}
