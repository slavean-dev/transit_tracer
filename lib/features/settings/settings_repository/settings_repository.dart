import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit_tracer/core/constants/app_constants.dart';
import 'package:transit_tracer/features/settings/settings_repository/abstract_settings_repository.dart';

class SettingsRepository implements AbstractSettingsRepository {
  SettingsRepository({
    required this.sharedPreferences,
    required this.dispatcher,
  });
  final SharedPreferences sharedPreferences;
  final PlatformDispatcher dispatcher;

  @override
  Future<ThemeMode> loadThemeMode() async {
    final values = sharedPreferences.getString(StorageConstants.themeKey);

    switch (values) {
      case AppConfig.themeLight:
        return ThemeMode.light;
      case AppConfig.themeDark:
        return ThemeMode.dark;
      case AppConfig.themeSystem:
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => AppConfig.themeLight,
      ThemeMode.dark => AppConfig.themeDark,
      ThemeMode.system => AppConfig.themeSystem,
    };

    await sharedPreferences.setString(StorageConstants.themeKey, value);
  }

  @override
  Future<String> loadLangCode() async {
    final savedValue = sharedPreferences.getString(StorageConstants.langKey);

    final valueToCheck = savedValue ?? dispatcher.locale.languageCode;

    final isSupported = AppConfig.supportedLanguages.any(
      (lang) => lang.code == valueToCheck,
    );

    return isSupported ? valueToCheck : AppConfig.defaultLangCode;
  }

  @override
  Future<void> saveLocale(String langCode) async {
    await sharedPreferences.setString(StorageConstants.langKey, langCode);
  }
}
