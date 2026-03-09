class CitySuggestion {
  CitySuggestion({required this.cityName, required this.placeId});

  final String cityName;
  final String placeId;

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      cityName: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
    );
  }
}
