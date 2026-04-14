import 'package:dio/dio.dart';
import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/services/geo_api_service/abstract_geo_service.dart';

class GeoApiService implements AbstractGeoService {
  GeoApiService(this.apiKey);

  final String apiKey;
  final Dio _dio = Dio();

  @override
  Future<Response<dynamic>> searchCities({
    required String query,
    required String langCode,
    int? limit,
  }) async {
    final url = GoogleApiConstants.autocompleteUrl;
    final response = await _dio.get(
      url,
      queryParameters: {
        GoogleApiConstants.inputParam: query,
        GoogleApiConstants.typesParam: GoogleApiConstants.citiesType,
        GoogleApiConstants.languageParam: langCode,
        GoogleApiConstants.componentsParam: GoogleApiConstants.defaultCountry,
        GoogleApiConstants.limitParam: limit,
        GoogleApiConstants.keyParam: apiKey,
      },
    );

    return response;
  }

  @override
  Future<Response<dynamic>> getPlaceDetails(
    String placeId,
    String langCode,
  ) async {
    final url = GoogleApiConstants.placeDetailsUrl;
    final response = await _dio.get(
      url,
      queryParameters: {
        GoogleApiConstants.placeIdParam: placeId,
        GoogleApiConstants.fieldsParam: GoogleApiConstants.detailsFields,
        GoogleApiConstants.languageParam: langCode,
        GoogleApiConstants.keyParam: apiKey,
      },
    );

    return response;
  }

  @override
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
