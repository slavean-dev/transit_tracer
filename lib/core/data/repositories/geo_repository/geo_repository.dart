import 'package:transit_tracer/core/constants/app_constants.dart';
import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/data/models/city_details/city_details.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_errors_parser.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/services/geo_api_service/abstract_geo_service.dart';

class GeoRepository implements AbstractGeoRepository {
  GeoRepository({required this.geoService});
  final AbstractGeoService geoService;

  @override
  Future<CityDetails> getPlaceDetails(String placeId, String langCode) async {
    try {
      final response = await geoService.getPlaceDetails(placeId, langCode);

      if (response.statusCode == 200 && response.data != null) {
        final String status = response.data[GoogleApiConstants.status] ?? '';

        if (status == GoogleApiConstants.statusOk) {
          return CityDetails.fromJson(response.data);
        }

        throw Exception(status);
      }

      throw Exception(
        '${GoogleApiConstants.serverErrorPrefix} ${response.statusCode}',
      );
    } catch (e) {
      final type = GeoErrorsParser.map(e);
      throw GeoFailure(e.toString(), type: type);
    }
  }

  @override
  Future<(Map<String, String>, Map<String, double>)> getCityFullBundle(
    String placeId,
  ) async {
    try {
      final requests = AppConfig.supportedLanguages.map((lang) {
        return getPlaceDetails(placeId, lang.code);
      }).toList();

      final results = await Future.wait(requests);

      final nameByLang = <String, String>{};
      for (var i = 0; i < AppConfig.supportedLanguages.length; i++) {
        final langCode = AppConfig.supportedLanguages[i].code;
        nameByLang[langCode] = results[i].localizedName;
      }

      final firstResult = results.first;
      final coordinates = {
        GoogleApiConstants.lat: firstResult.lat,
        GoogleApiConstants.lng: firstResult.lng,
      };

      return (nameByLang, coordinates);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> fetchEncodedPolyline({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  }) async {
    try {
      final response = await geoService.getRoute(
        fromLat: fromLat,
        fromLng: fromLng,
        toLat: toLat,
        toLng: toLng,
      );

      final data = response.data;
      if (data == null) return null;

      final routes = (data['routes'] as List?) ?? const [];
      if (routes.isEmpty) return null;

      final overview =
          routes.first['overview_polyline'] as Map<String, dynamic>;
      return overview['points'] as String?;
    } catch (e) {
      return null;
    }
  }
}
