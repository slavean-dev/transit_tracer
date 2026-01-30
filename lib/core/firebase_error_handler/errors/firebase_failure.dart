import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';

class FirebaseFailure implements Exception {
  FirebaseFailure(this.message, {required this.type});
  final FirebaseErrorType type;
  final String? message;
}
