class GoogleApiConstants {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  static const String autocompleteUrl = '$_baseUrl/autocomplete/json';
  static const String placeDetailsUrl = '$_baseUrl/details/json';

  static const String inputParam = 'input';
  static const String typesParam = 'types';
  static const String languageParam = 'language';
  static const String componentsParam = 'components';
  static const String limitParam = 'limit';
  static const String keyParam = 'key';
  static const String results = 'result';
  static const String placeIdParam = 'place_id';
  static const String fieldsParam = 'fields';

  static const String citiesType = '(cities)';
  static const String defaultCountry = 'country:ua';
  static const String detailsFields = 'name,geometry,address_components';

  static const String adressComponents = 'address_components';
  static const String types = 'types';
  static const String locality = 'locality';
  static const String adminAreaLevel1 = 'administrative_area_level_1';
  static const String country = 'country';
  static const String longName = 'long_name';
  static const String geometry = 'geometry';
  static const String location = 'location';
  static const String lat = 'lat';
  static const String lng = 'lng';
  static const String predictions = 'predictions';
  static const String status = 'status';
  static const String statusOk = 'OK';

  static const String serverErrorPrefix = 'Server Error:';

  static const String staticMapBaseUrl =
      'https://maps.googleapis.com/maps/api/staticmap';

  static const int defaultMapWidth = 900;
  static const int defaultMapHeight = 320;
  static const int defaultMapScale = 2;
  static const int maxPathPoints = 80;

  static const String markerColor = '0x1f1f1f';
  static const String labelStart = 'A';
  static const String labelEnd = 'B';

  static const String pathColor = 'FFA000';
  static const String pathWeight = '6';

  static const String size = 'size';
  static const String scale = 'scale';
  static const String markers = 'markers';
  static const String path = 'path';

  static const String externalMapsBaseUrl = 'https://www.google.com/maps/dir/';

  static const String apiParam = 'api';
  static const String apiVersion = '1';
  static const String origin = 'origin';
  static const String destination = 'destination';
  static const String travelMode = 'travelmode';
  static const String drivingMode = 'driving';
}

class GeoErrorsCodes {
  static const String queryLimit = 'OVER_QUERY_LIMIT';

  static const String zeroResults = 'ZERO_RESULTS';

  static const String requestDenied = 'REQUEST_DENIED';

  static const String invalidRequest = 'INVALID_REQUEST';

  static const String unknownError = 'UNKNOWN_ERROR';
}

class GeoNetworkPatterns {
  static const socket = 'socketexception';
  static const connection = 'connection failed';
  static const network = 'network_error';
}

class EnvKeys {
  static const String googlePlacesApiKey = "GOOGLE_PLACES_API_KEY";
}
