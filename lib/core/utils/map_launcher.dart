import 'package:url_launcher/url_launcher.dart';

Future<void> openRouteInGoogleMaps({
  required double fromLat,
  required double fromLng,
  required double toLat,
  required double toLng,
}) async {
  final uri = Uri.parse(
    'https://www.google.com/maps/dir/?api=1'
    '&origin=$fromLat,$fromLng'
    '&destination=$toLat,$toLng'
    '&travelmode=driving',
  );

  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok) {
    throw Exception('Could not open Google Maps');
  }
}
