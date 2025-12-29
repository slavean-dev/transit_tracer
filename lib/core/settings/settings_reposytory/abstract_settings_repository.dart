import 'package:flutter/material.dart';

abstract class AbstractSettingsRepository {
  Future<ThemeMode> loadThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
  Future<String> loadLangCode();
  Future<void> saveLocale(String langCode);
}
