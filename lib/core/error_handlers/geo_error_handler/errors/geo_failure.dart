import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';

class GeoFailure implements Exception {
  GeoFailure(this.message, {required this.type});
  final GeoErrorType type;
  final String? message;
}
