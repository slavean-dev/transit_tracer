class CityPoint {
  CityPoint({
    required this.name,
    required this.placeId,
    required this.lat,
    required this.lng,
    this.localizedNames = const {},
  });
  final String name;
  final String placeId;
  final double lat;
  final double lng;
  final Map<String, String> localizedNames;

  CityPoint copyWith({Map<String, String>? localizedNames}) {
    return CityPoint(
      name: name,
      placeId: placeId,
      lat: lat,
      lng: lng,
      localizedNames: localizedNames ?? this.localizedNames,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'placeId': placeId,
    'lat': lat,
    'lng': lng,
    'localizedNames': localizedNames,
  };

  factory CityPoint.fromJson(Map<String, dynamic> json) => CityPoint(
    name: json['name'] as String,
    placeId: json['placeId'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    localizedNames: Map<String, String>.from(json['localizedNames'] ?? {}),
  );
}
