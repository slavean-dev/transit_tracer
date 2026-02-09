import 'package:transit_tracer/core/constants/firebase_errors_codes.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';

class FirebaseAuthErrors {
  static FirebaseErrorType map(String code) {
    switch (code) {
      case FirebaseErrors.emailInUse:
        return FirebaseErrorType.emailAlreadyInUse;
      case FirebaseErrors.invalidEmail:
        return FirebaseErrorType.invalidEmail;
      case FirebaseErrors.weekPassword:
        return FirebaseErrorType.weakPassword;
      case FirebaseErrors.userNotFound:
        return FirebaseErrorType.userNotFound;
      case FirebaseErrors.wrongPassword:
        return FirebaseErrorType.wrongPassword;
      case FirebaseErrors.invalidCredential:
        return FirebaseErrorType.invalidCredential;
      case FirebaseErrors.tooManyRequests:
        return FirebaseErrorType.toManyRequests;
      case FirebaseErrors.primissionDenied:
        return FirebaseErrorType.primissionDenied;
      case FirebaseErrors.notFound:
        return FirebaseErrorType.notFound;
      case FirebaseErrors.unavailable:
        return FirebaseErrorType.unavailable;
      case FirebaseErrors.networkError:
        return FirebaseErrorType.networkError;
      default:
        return FirebaseErrorType.unknown;
    }
  }
}
