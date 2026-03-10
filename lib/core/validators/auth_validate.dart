import 'package:email_validator/email_validator.dart';
import 'package:transit_tracer/core/constants/app_regex.dart';

bool isNotEmpty(String? value) {
  return value != null && value.trim().isNotEmpty;
}

String? validateRequired(String? value, {required String emptyField}) {
  if (!isNotEmpty(value)) {
    return emptyField;
  }
  return null;
}

String? validateEmail(
  String? value, {
  required String emptyField,
  required String invalidEmail,
}) {
  if (!isNotEmpty(value)) {
    return emptyField;
  }
  if (!EmailValidator.validate(value!)) {
    return invalidEmail;
  }
  return null;
}

String? validateName(
  String? value, {
  required String emptyField,
  required String invalidValue,
}) {
  if (!isNotEmpty(value)) {
    return emptyField;
  }
  final reg = AppRegex.name;
  if (!reg.hasMatch(value!.trim())) {
    return invalidValue;
  }
  return null;
}

String? validatePhone(
  String? value, {
  required String emptyField,
  required String invalidPhone,
}) {
  final digits = value?.replaceAll(AppRegex.nonDigits, '') ?? '';
  if (digits.isEmpty) return emptyField;
  if (digits.length != 9) return invalidPhone;
  return null;
}

String? validatePassword(
  String? value, {
  required String emptyField,
  required String inavildLenth,
  required String invalidUppercase,
  required String invalidDigit,
  required String invalidCpecChar,
}) {
  if (!isNotEmpty(value)) {
    return emptyField;
  }
  final password = value!.trim();
  if (password.length < 8) {
    return inavildLenth;
  }
  if (!AppRegex.upperCase.hasMatch(password)) {
    return invalidUppercase;
  }
  if (!AppRegex.passwordDigit.hasMatch(password)) {
    return invalidDigit;
  }
  if (!AppRegex.passwordSpecialChar.hasMatch(password)) {
    return invalidCpecChar;
  }
  return null;
}

String? validateCoinfirmPassword(
  String? value,
  String originalPassword, {
  required String emptyField,
  required String passwordsDidntMatch,
}) {
  if (!isNotEmpty(value)) {
    return emptyField;
  }
  if (value!.trim() != originalPassword.trim()) {
    return passwordsDidntMatch;
  }
  return null;
}
