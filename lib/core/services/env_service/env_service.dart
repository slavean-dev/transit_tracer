import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  String? _autocompleteApiKey;

  void initEnv() {
    _autocompleteApiKey = dotenv.env["AUTOCOPLETE_API_KEY"];
  }

  String get autocompleteApiKey => _autocompleteApiKey ?? '';
}
