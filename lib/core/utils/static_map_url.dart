import 'package:transit_tracer/core/utils/polyline_decode.dart';

class StaticMapUrl {
  static String buildRoutePreview({
    required String apiKey,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    int width = 900,
    int height = 320,
    int scale = 2,
  }) {
    final markersA = 'markers=color:0x1f1f1f|label:A|$fromLat,$fromLng';
    final markersB = 'markers=color:0x1f1f1f|label:B|$toLat,$toLng';

    final path = 'path=color:0xFFA000|weight:6|$fromLat,$fromLng|$toLat,$toLng';

    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?size=${width}x$height'
        '&scale=$scale'
        '&$markersA'
        '&$markersB'
        '&$path'
        '&key=$apiKey';
  }

  static String buildRouteByRoads({
    required String apiKey,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    required List<LatLng> pathPoints,
    int width = 900,
    int height = 320,
    int scale = 2,
  }) {
    final markersA = 'markers=color:0x1f1f1f|label:A|$fromLat,$fromLng';
    final markersB = 'markers=color:0x1f1f1f|label:B|$toLat,$toLng';

    final simplified = _downsample(pathPoints, maxPoints: 80);

    final pathStr = simplified.map((p) => '${p.lat},${p.lng}').join('|');
    final path = 'path=color:0xFFA000|weight:6|$pathStr';

    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?size=${width}x$height'
        '&scale=$scale'
        '&$markersA'
        '&$markersB'
        '&$path'
        '&key=$apiKey';
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
