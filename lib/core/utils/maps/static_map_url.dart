import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/utils/mappers/polyline_decode.dart';

class StaticMapUrl {
  static String buildRoutePreview({
    required String apiKey,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    int width = GoogleApiConstants.defaultMapWidth,
    int height = GoogleApiConstants.defaultMapHeight,
    int scale = GoogleApiConstants.defaultMapScale,
  }) {
    final markerStyle = 'color:${GoogleApiConstants.markerColor}';

    final markersA =
        '${GoogleApiConstants.markers}=$markerStyle|label:${GoogleApiConstants.labelStart}|$fromLat,$fromLng';
    final markersB =
        '${GoogleApiConstants.markers}=$markerStyle|label:${GoogleApiConstants.labelEnd}|$toLat,$toLng';

    final pathStyle =
        'color:0x${GoogleApiConstants.pathColor}|weight:${GoogleApiConstants.pathWeight}';
    final path =
        '${GoogleApiConstants.path}=$pathStyle|$fromLat,$fromLng|$toLat,$toLng';

    return '${GoogleApiConstants.staticMapBaseUrl}'
        '?${GoogleApiConstants.size}=$width$height'
        '&${GoogleApiConstants.scale}=$scale'
        '&$markersA'
        '&$markersB'
        '&$path'
        '&${GoogleApiConstants.keyParam}=$apiKey';
  }

  static String buildRouteByRoads({
    required String apiKey,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    required List<LatLng> pathPoints,
    int width = GoogleApiConstants.defaultMapWidth,
    int height = GoogleApiConstants.defaultMapHeight,
    int scale = GoogleApiConstants.defaultMapScale,
  }) {
    final markerStyle = 'color:${GoogleApiConstants.markerColor}';
    final markersA =
        '${GoogleApiConstants.markers}=$markerStyle|label:${GoogleApiConstants.labelStart}|$fromLat,$fromLng';
    final markersB =
        '${GoogleApiConstants.markers}=$markerStyle|label:${GoogleApiConstants.labelEnd}|$toLat,$toLng';

    final simplified = _downsample(
      pathPoints,
      maxPoints: GoogleApiConstants.maxPathPoints,
    );

    final pathStr = simplified.map((p) => '${p.lat},${p.lng}').join('|');
    final path =
        '${GoogleApiConstants.path}=color:0x${GoogleApiConstants.pathColor}|weight:${GoogleApiConstants.pathWeight}|$pathStr';

    return '${GoogleApiConstants.staticMapBaseUrl}'
        '?${GoogleApiConstants.size}=${width}x$height'
        '&${GoogleApiConstants.scale}=$scale'
        '&$markersA'
        '&$markersB'
        '&$path'
        '&${GoogleApiConstants.keyParam}=$apiKey';
  }

  static List<LatLng> _downsample(List<LatLng> pts, {required int maxPoints}) {
    if (pts.length <= maxPoints) return pts;
    final step = (pts.length / maxPoints).ceil();
    final out = <LatLng>[];
    for (int i = 0; i < pts.length; i += step) {
      out.add(pts[i]);
    }
    if (out.isEmpty ||
        (out.last.lat != pts.last.lat || out.last.lng != pts.last.lng)) {
      out.add(pts.last);
    }
    return out;
  }
}
