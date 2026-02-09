part of 'password_strength_meter_cubit.dart';

class PasswordStrengthMeterState extends Equatable {
  const PasswordStrengthMeterState();

  @override
  List<Object> get props => [];
}

class PasswordStrengthMeterInitial extends PasswordStrengthMeterState {}

class PasswordStrengthMeterChecked extends PasswordStrengthMeterState {
  const PasswordStrengthMeterChecked({
    required this.color,
    required this.level,
  });

  final Color color;
  final double level;

  @override
  List<Object> get props => [color, level];
}

class PasswordFieldEmpty extends PasswordStrengthMeterState {
  final Color color = const Color(0xFF3A3A3C);
  final double level = 0;
}
