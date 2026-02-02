import 'package:flutter/widgets.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/generated/l10n.dart';

class ErrorTranslator {
  static String? translate(BuildContext context, FirebaseErrorType? type) {
    if (type == null) return null;

    final s = S.of(context);
    switch (type) {
      case FirebaseErrorType.invalidCredential:
        return s.firebaseErrorInvalidCredential;
      case FirebaseErrorType.emailAlreadyInUse:
        return s.firebaseErrorEmailInUse;
      case FirebaseErrorType.invalidEmail:
        return s.firebaseErrorInvalidEmail;
      case FirebaseErrorType.weakPassword:
        return s.firebaseErrorWeekPassword;
      case FirebaseErrorType.userNotFound:
        return s.firebaseErrorUserNotFound;
      case FirebaseErrorType.wrongPassword:
        return s.firebaseErrorWrongPassword;
      // case FirebaseErrorType.toManyRequests:
      //   return s.firebaseValidationTooManyRequests;
      case FirebaseErrorType.primissionDenied:
        return s.firebaseErrorPermissionDenied;
      case FirebaseErrorType.notFound:
        return s.firebaseErrorNotFound;
      case FirebaseErrorType.unavailable:
        return s.firebaseErrorUnavailable;
      case FirebaseErrorType.networkError:
        return s.firebaseErrorNetwork;
      default:
        return s.firebaseErrorSomethingWrong;
    }
  }
}
