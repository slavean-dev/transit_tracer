class CityPoint {
  CityPoint({
    required this.name,
    required this.placeId,
    required this.lat,
    required this.lng,
  });
  final String name;
  final String placeId;
  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => {
    'name': name,
    'placeId': placeId,
    'lat': lat,
    'lng': lng,
  };

  factory CityPoint.fromJson(Map<String, dynamic> json) => CityPoint(
    name: json['name'] as String,
    placeId: json['placeId'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}
