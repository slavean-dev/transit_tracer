import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';

class GeoErrorsParser {
  static GeoErrorType map(Object code) {
    final error = code.toString().toLowerCase();

    if (error.contains(GeoNetworkPatterns.socket) ||
        error.contains(GeoNetworkPatterns.connection) ||
        error.contains(GeoNetworkPatterns.network)) {
      return GeoErrorType.network;
    }

    if (error.contains(GeoErrorsCodes.queryLimit.toLowerCase())) {
      return GeoErrorType.apiLimit;
    }
    if (error.contains(GeoErrorsCodes.requestDenied.toLowerCase())) {
      return GeoErrorType.denied;
    }
    if (error.contains(GeoErrorsCodes.invalidRequest.toLowerCase())) {
      return GeoErrorType.invalidRequest;
    }
    if (error.contains(GeoErrorsCodes.zeroResults.toLowerCase())) {
      return GeoErrorType.resultsEmpty;
    }

    return GeoErrorType.unknown;
  }
}
