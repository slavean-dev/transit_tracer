import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openRouteInGoogleMaps({
  required double fromLat,
  required double fromLng,
  required double toLat,
  required double toLng,
}) async {
  final uri = Uri.parse(GoogleApiConstants.externalMapsBaseUrl).replace(
    queryParameters: {
      GoogleApiConstants.apiParam: GoogleApiConstants.apiVersion,
      GoogleApiConstants.origin: '$fromLat,$fromLng',
      GoogleApiConstants.destination: '$toLat,$toLng',
      GoogleApiConstants.travelMode: GoogleApiConstants.drivingMode,
    },
  );

  final bool canLaunch = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  if (!canLaunch) {
    // TODO: Replace with custom AppException
    throw Exception('Could not open Google Maps');
  }
}
