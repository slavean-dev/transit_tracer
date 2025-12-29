import 'package:email_validator/email_validator.dart';

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
  final reg = RegExp(r"[A-Za-zА-Яа-яІіЇїЄє]{2,}$");
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
  final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
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
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return invalidUppercase;
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return invalidDigit;
  }
  if (!RegExp(
    r'[!@#\$%\^&\*\(\)_\+\-=\{\}\[\]:;"\<>,\.\?\/\\]',
  ).hasMatch(password)) {
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
