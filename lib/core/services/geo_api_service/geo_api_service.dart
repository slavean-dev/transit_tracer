import 'package:dio/dio.dart';

class GeoApiService {
  GeoApiService(this.apiKey);
  final String apiKey;
  final Dio _dio = Dio();

  Future<Response<dynamic>> searchCities({
    required String query,
    required String langCode,
    int limit = 5,
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

  Future<String> getLocalizedPlaceName(
    String placeId,
    String languageCode,
  ) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'place_id': placeId,
          'fields': 'address_components',
          'language': languageCode,
          'key': apiKey,
        },
      );

      String city = '';
      String region = '';
      String country = '';

      final data = response.data;
      if (data['status'] == 'OK') {
        final components = data['result']['address_components'];

        for (var com in components) {
          final types = com['types'] as List;
          if (types.contains('locality')) {
            city = com['long_name'];
          }
          if (types.contains('administrative_area_level_1')) {
            region = com['long_name'];
          }
          if (types.contains('country')) {
            country = com['long_name'];
          }
        }
        final fullAdress = [
          city,
          region,
          country,
        ].where((s) => s.isNotEmpty).join(', ');
        return fullAdress;
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
