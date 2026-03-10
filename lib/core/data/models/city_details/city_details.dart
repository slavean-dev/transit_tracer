import 'package:transit_tracer/core/constants/google_api_constants.dart';
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
    final result = json[GoogleApiConstants.results] ?? {};
    final components =
        result[GoogleApiConstants.adressComponents] as List<dynamic>;

    String city = '';
    String region = '';
    String country = '';

    for (var com in components) {
      final types = com[GoogleApiConstants.types] as List<dynamic>;
      if (types.contains(GoogleApiConstants.locality)) {
        city = com[GoogleApiConstants.longName];
      }
      if (types.contains(GoogleApiConstants.adminAreaLevel1)) {
        region = com[GoogleApiConstants.longName];
      }
      if (types.contains(GoogleApiConstants.country)) {
        country = com[GoogleApiConstants.longName];
      }
    }
    final fullAddress = [
      city,
      region,
      country,
    ].where((s) => s.isNotEmpty).join(', ');

    final location =
        result[GoogleApiConstants.geometry][GoogleApiConstants.location];

    return CityDetails(
      localizedName: fullAddress,
      lat: NumUtils().toDouble(location[GoogleApiConstants.lat]) ?? 0.0,
      lng: NumUtils().toDouble(location[GoogleApiConstants.lng]) ?? 0.0,
    );
  }
}
