import 'package:transit_tracer/core/data/models/city_details/city_details.dart';

abstract class AbstractGeoRepository {
  Future<CityDetails> getPlaceDetails(String placeId, String langCode);
  Future<(Map<String, String>, Map<String, double>)> getCityFullBundle(
    String placeId,
  );
}
