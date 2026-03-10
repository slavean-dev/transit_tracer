import 'package:transit_tracer/core/constants/firebase_constants.dart';

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
    FirebaseConstants.name: name,
    FirebaseConstants.placeId: placeId,
    FirebaseConstants.lat: lat,
    FirebaseConstants.lng: lng,
    FirebaseConstants.localizedNames: localizedNames,
  };

  factory CityPoint.fromJson(Map<String, dynamic> json) => CityPoint(
    name: json[FirebaseConstants.name] as String,
    placeId: json[FirebaseConstants.placeId] as String,
    lat: (json[FirebaseConstants.lat] as num).toDouble(),
    lng: (json[FirebaseConstants.lng] as num).toDouble(),
    localizedNames: Map<String, String>.from(
      json[FirebaseConstants.localizedNames] ?? {},
    ),
  );
}
