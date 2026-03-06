import 'package:transit_tracer/core/data/models/city_details/city_details.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/services/geo_api_service/geo_api_service.dart';

class GeoRepository implements AbstractGeoRepository {
  GeoRepository({required this.geoService});
  final GeoApiService geoService;

  @override
  Future<CityDetails> getPlaceDetails(String placeId, String langCode) async {
    try {
      final response = await geoService.getPlaceDetails(placeId, langCode);

      if (response.statusCode == 200) {
        if (response.data['status'] == 'OK') {
          return CityDetails.fromJson(response.data);
        } else {
          throw Exception('Google API Error: ${response.data['status']}');
        }
      }

      throw Exception('Google API Error: ${response.data['status']}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Map<String, String>, Map<String, double>)> getCityFullBundle(
    String placeId,
  ) async {
    try {
      final results = await Future.wait([
        getPlaceDetails(placeId, 'en'),
        getPlaceDetails(placeId, 'uk'),
        getPlaceDetails(placeId, 'it'),
      ]);

      return (
        {
          'en': results[0].localizedName,
          'uk': results[1].localizedName,
          'it': results[2].localizedName,
        },
        {'lat': results[0].lat, 'lng': results[0].lng},
      );
    } catch (e) {
      return (<String, String>{}, <String, double>{});
    }
  }
}
