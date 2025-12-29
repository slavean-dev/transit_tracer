import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/settings/settings_reposytory/abstract_settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repo) : super(SettingsInitial());

  final AbstractSettingsRepository _repo;

  /// вызывать один раз при старте приложения
  Future<void> init() async {
    final theme = await _repo.loadThemeMode();
    final lang = await _repo.loadLangCode();
    emit(SettingsDataLoaded(mode: theme, langCode: lang));
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _repo.saveThemeMode(mode);

    final current = state;
    if (current is SettingsDataLoaded) {
      emit(SettingsDataLoaded(mode: mode, langCode: current.langCode));
    }
  }

  Future<void> toggleDarkLight() async {
    final current = state;
    if (current is! SettingsDataLoaded) return;

    final next = current.mode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await setTheme(next);
  }

  Future<void> setLangCode(String code) async {
    await _repo.saveLocale(code);

    final current = state;
    if (current is SettingsDataLoaded) {
      emit(SettingsDataLoaded(mode: current.mode, langCode: code));
    }
  }
}
