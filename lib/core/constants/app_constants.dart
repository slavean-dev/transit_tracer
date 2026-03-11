class LanguageModel {
  const LanguageModel({required this.code, required this.name});
  final String code;
  final String name;
}

class AppConfig {
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(code: 'en', name: 'English'),
    LanguageModel(code: 'uk', name: 'Українська'),
    LanguageModel(code: 'it', name: 'Italiano'),
  ];
  static const String defaultLangCode = 'en';

  static const String themeLight = 'light';
  static const String themeDark = 'dark';
  static const String themeSystem = 'system';
}

class AssetsPath {
  static const String transitTracerLogo = 'assets/logo/logo.png';
}

class StorageConstants {
  static const String themeKey = 'theme_mode';
  static const String langKey = 'lang_code';
}

class SupEmail {
  static const String supEmail = 'suptransittracer@outlook.com';
}
