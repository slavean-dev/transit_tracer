import 'package:dio/dio.dart';

class GoogleRouteService {
  GoogleRouteService({required this.dio, required this.apiKey});

  final Dio dio;
  final String apiKey;

  Future<String?> fetchEncodedPolyline({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      'https://maps.googleapis.com/maps/api/directions/json',
      queryParameters: {
        'origin': '$fromLat,$fromLng',
        'destination': '$toLat,$toLng',
        'mode': 'driving',
        'key': apiKey,
      },
    );

    final data = response.data;
    if (data == null) return null;

    final routes = (data['routes'] as List?) ?? const [];
    if (routes.isEmpty) return null;

    final overview = routes.first['overview_polyline'] as Map<String, dynamic>;
    return overview['points'] as String?;
  }
}
