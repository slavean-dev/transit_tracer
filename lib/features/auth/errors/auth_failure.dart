import 'package:transit_tracer/core/models/auth_error_type/auth_error_type.dart';

class AuthFailure implements Exception {
  AuthFailure({required this.type});
  final AuthErrorType type;
}
