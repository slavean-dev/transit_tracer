import 'package:flutter/cupertino.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/generated/l10n.dart';

class GeoErrorTranslator {
  static String? translate(BuildContext context, GeoErrorType? type) {
    if (type == null) return null;
    final s = S.of(context);
    switch (type) {
      case GeoErrorType.network:
        return s.geoErrorNetwork;
      case GeoErrorType.apiLimit:
        return s.geoErrorApiLimit;
      case GeoErrorType.denied:
        return s.geoErrorDenied;
      case GeoErrorType.invalidRequest:
        return s.geoErrorInvalidRequest;
      case GeoErrorType.resultsEmpty:
        return s.geoErrorZeroResults;
      default:
        return s.geoErrorUnknown;
    }
  }
}
