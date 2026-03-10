import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:transit_tracer/core/constants/app_regex.dart';
import 'package:transit_tracer/generated/l10n.dart';

enum AuthValidationError {
  empty,
  invalidEmail,
  invalidName,
  invalidPhone,
  tooShort,
  noUppercase,
  noDigit,
  noSpecialChar,
  mismatch,
}

class AuthValidator {
  static AuthValidationError? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AuthValidationError.empty;
    }
    return null;
  }

  static AuthValidationError? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AuthValidationError.empty;
    }
    if (!EmailValidator.validate(value)) {
      return AuthValidationError.invalidEmail;
    }
    return null;
  }

  static AuthValidationError? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AuthValidationError.empty;
    }
    final reg = AppRegex.name;
    if (!reg.hasMatch(value.trim())) {
      return AuthValidationError.invalidName;
    }
    return null;
  }

  static AuthValidationError? validatePhone(String? value) {
    final digits = value?.replaceAll(AppRegex.nonDigits, '') ?? '';
    if (digits.isEmpty) return AuthValidationError.empty;
    if (digits.length != 9) return AuthValidationError.invalidPhone;
    return null;
  }

  static AuthValidationError? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AuthValidationError.empty;
    }
    final password = value.trim();
    if (password.length < 8) {
      return AuthValidationError.tooShort;
    }
    if (!AppRegex.upperCase.hasMatch(password)) {
      return AuthValidationError.noUppercase;
    }
    if (!AppRegex.passwordDigit.hasMatch(password)) {
      return AuthValidationError.noDigit;
    }
    if (!AppRegex.passwordSpecialChar.hasMatch(password)) {
      return AuthValidationError.noSpecialChar;
    }
    return null;
  }

  static AuthValidationError? validateCoinfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return AuthValidationError.empty;
    }
    if (value.trim() != originalPassword.trim()) {
      return AuthValidationError.mismatch;
    }
    return null;
  }
}

extension AuthValidationErrorX on AuthValidationError {
  String toText(BuildContext context) {
    final s = S.of(context);
    return switch (this) {
      AuthValidationError.empty => s.validationFormEmpty,
      AuthValidationError.invalidEmail => s.validationInvalidEmail,
      AuthValidationError.invalidName => s.validationInvalidName,
      AuthValidationError.invalidPhone => s.validationInvalidPhone,
      AuthValidationError.tooShort => s.validationInvalidPasswordLenth,
      AuthValidationError.noUppercase => s.validationInvalidPasswordUppercase,
      AuthValidationError.noDigit => s.validationInvalidPasswordDigit,
      AuthValidationError.noSpecialChar => s.validationInvalidPasswordSpecChar,
      AuthValidationError.mismatch =>
        s.validationInvalidConfirmPasswordDidntMatch,
    };
  }
}
