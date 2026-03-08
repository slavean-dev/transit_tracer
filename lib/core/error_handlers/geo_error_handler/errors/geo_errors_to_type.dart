import 'package:transit_tracer/core/constants/geo_errors_codes.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';

class GeoErrorsToType {
  static GeoErrorType map(Object code) {
    final error = code.toString();
    if (error.contains(GeoErrorsCodes.queryLimit)) return GeoErrorType.apiLimit;
    if (error.contains(GeoErrorsCodes.requestDenied)) {
      return GeoErrorType.denied;
    }
    if (error.contains(GeoErrorsCodes.invalidRequest)) {
      return GeoErrorType.invalidRequest;
    }
    if (error.contains(GeoErrorsCodes.zeroResults)) {
      return GeoErrorType.resultsEmpty;
    }

    return GeoErrorType.unknown;
  }
}
