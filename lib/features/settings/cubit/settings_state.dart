part of 'settings_cubit.dart';

class SettingsState {
  const SettingsState({
    this.mode = ThemeMode.system,
    this.langCode = 'en',
    this.isOnline = true,
  });

  final ThemeMode mode;
  final String langCode;
  final bool isOnline;

  SettingsState copyWith({ThemeMode? mode, String? langCode, bool? isOnline}) {
    return SettingsState(
      mode: mode ?? this.mode,
      langCode: langCode ?? this.langCode,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

// class SettingsInitial extends SettingsState {}

// class SettingsDataLoaded extends SettingsState {
//   const SettingsDataLoaded({required this.mode, required this.langCode});
//   final ThemeMode mode;
//   final String langCode;

//   @override
//   List<Object> get props => [mode, langCode];
// }
