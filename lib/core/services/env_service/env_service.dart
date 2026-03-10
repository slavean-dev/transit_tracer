import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:transit_tracer/core/constants/google_api_constants.dart';

class EnvService {
  String? _googlePlacesApiKey;

  void initEnv() {
    _googlePlacesApiKey = dotenv.env[EnvKeys.googlePlacesApiKey];
  }

  String get googlePlacesApiKey => _googlePlacesApiKey ?? '';
}
