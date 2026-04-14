import 'package:dio/dio.dart';

abstract class AbstractGeoService {
  Future<Response<dynamic>> searchCities({
    required String query,
    required String langCode,
    int? limit,
  });
  Future<Response<dynamic>> getPlaceDetails(String placeId, String langCode);
  Future<Response<dynamic>> getRoute({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  });
}
