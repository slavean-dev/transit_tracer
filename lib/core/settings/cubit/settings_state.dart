part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsDataLoaded extends SettingsState {
  const SettingsDataLoaded({required this.mode, required this.langCode});
  final ThemeMode mode;
  final String langCode;

  @override
  List<Object> get props => [mode, langCode];
}
