import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_strength_meter_state.dart';

class PasswordStrengthMeterCubit extends Cubit<PasswordStrengthMeterState> {
  PasswordStrengthMeterCubit() : super(PasswordStrengthMeterInitial());

  void passwordFieldEmpty() => emit(PasswordFieldEmpty());

  void checkPassword(String password) {
    final int uppercaseCount = RegExp(r'[A-Z]').allMatches(password).length;
    final int numberCount = RegExp(r'\d').allMatches(password).length;
    final int specialCount = RegExp(
      r'!@#\$%\^&\*\(\)_\+\-=\{\}\[\]:;"\<>,\.\?\/\\',
    ).allMatches(password).length;

    if (password.length <= 8 ||
        uppercaseCount <= 1 ||
        numberCount <= 2 ||
        specialCount <= 1) {
      emit(PasswordStrengthMeterChecked(color: Color(0xFFE53935), level: 0.33));
    } else if (password.length <= 10 ||
        uppercaseCount <= 2 ||
        numberCount <= 4 ||
        specialCount <= 3) {
      emit(PasswordStrengthMeterChecked(color: Color(0xFFFFA000), level: 0.66));
    } else {
      emit(PasswordStrengthMeterChecked(color: Color(0xFF66BB6A), level: 1));
    }
  }
}
