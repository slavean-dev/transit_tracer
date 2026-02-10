import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit_tracer/features/settings/settings_repository/abstract_settings_repository.dart';

class SettingsRepository implements AbstractSettingsRepository {
  SettingsRepository({
    required this.sharedPreferences,
    required this.dispatcher,
  });
  final SharedPreferences sharedPreferences;
  final PlatformDispatcher dispatcher;
  static const _themeKey = 'theme_mode';
  static const _langKey = 'lang_code';

  @override
  Future<ThemeMode> loadThemeMode() async {
    final values = sharedPreferences.getString(_themeKey);

    switch (values) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await sharedPreferences.setString(_themeKey, value);
  }

  @override
  Future<String> loadLangCode() async {
    String? values = sharedPreferences.getString(_langKey);

    values ??= dispatcher.locale.languageCode;

    switch (values) {
      case 'it':
        return 'it';
      case 'uk':
        return 'uk';
      case 'en':
      default:
        return 'en';
    }
  }

  @override
  Future<void> saveLocale(String langCode) async {
    await sharedPreferences.setString(_langKey, langCode);
  }
}
