import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';

class FirebaseAuthErrors {
  static FirebaseErrorType map(String code) {
    switch (code) {
      case FirebaseErrorsCodes.emailInUse:
        return FirebaseErrorType.emailAlreadyInUse;
      case FirebaseErrorsCodes.invalidEmail:
        return FirebaseErrorType.invalidEmail;
      case FirebaseErrorsCodes.weekPassword:
        return FirebaseErrorType.weakPassword;
      case FirebaseErrorsCodes.userNotFound:
        return FirebaseErrorType.userNotFound;
      case FirebaseErrorsCodes.wrongPassword:
        return FirebaseErrorType.wrongPassword;
      case FirebaseErrorsCodes.invalidCredential:
        return FirebaseErrorType.invalidCredential;
      case FirebaseErrorsCodes.tooManyRequests:
        return FirebaseErrorType.toManyRequests;
      case FirebaseErrorsCodes.primissionDenied:
        return FirebaseErrorType.primissionDenied;
      case FirebaseErrorsCodes.notFound:
        return FirebaseErrorType.notFound;
      case FirebaseErrorsCodes.unavailable:
        return FirebaseErrorType.unavailable;
      case FirebaseErrorsCodes.networkError:
        return FirebaseErrorType.networkError;
      default:
        return FirebaseErrorType.unknown;
    }
  }
}
