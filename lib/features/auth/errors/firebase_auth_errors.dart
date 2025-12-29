import 'package:transit_tracer/core/constants/firebase_errors.dart';
import 'package:transit_tracer/core/models/auth_error_type/auth_error_type.dart';

class FirebaseAuthErrors {
  static AuthErrorType map(String code) {
    switch (code) {
      case FirebaseErrors.emailInUse:
        return AuthErrorType.emailAlreadyInUse;
      case FirebaseErrors.invalidEmail:
        return AuthErrorType.invalidEmail;
      case FirebaseErrors.weekPassword:
        return AuthErrorType.weakPassword;
      case FirebaseErrors.userNotFound:
        return AuthErrorType.userNotFound;
      case FirebaseErrors.wrongPassword:
      case FirebaseErrors.invalidCredential:
        return AuthErrorType.wrongPassword;
      case FirebaseErrors.tooManyRequests:
        return AuthErrorType.toManyRequests;
      default:
        return AuthErrorType.unknown;
    }
  }
}
