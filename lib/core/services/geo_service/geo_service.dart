import 'package:dio/dio.dart';

class GeoService {
  GeoService(this.apiKey);
  final String apiKey;
  final Dio _dio = Dio();

  Future<String> getLocaliredPlaceName(
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
          if (types.contains(country)) {
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
