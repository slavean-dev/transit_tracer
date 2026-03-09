import 'package:transit_tracer/core/utils/formatters/num_utils.dart';

class CityDetails {
  CityDetails({
    required this.localizedName,
    required this.lat,
    required this.lng,
  });

  final String localizedName;
  final double lat;
  final double lng;

  factory CityDetails.fromJson(Map<String, dynamic> json) {
    final result = json['result'] ?? {};
    final components = result['address_components'] as List<dynamic>;

    String city = '';
    String region = '';
    String country = '';

    for (var com in components) {
      final types = com['types'] as List<dynamic>;
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

    final location = result['geometry']['location'];

    return CityDetails(
      localizedName: fullAdress,
      lat: NumUtils().toDouble(location['lat']) ?? 0.0,
      lng: NumUtils().toDouble(location['lng']) ?? 0.0,
    );
  }
}
