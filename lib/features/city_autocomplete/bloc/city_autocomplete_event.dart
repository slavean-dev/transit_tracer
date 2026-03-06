part of 'city_autocomplete_bloc.dart';

class CityAutocompleteEvent extends Equatable {
  const CityAutocompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadCitySuggestions extends CityAutocompleteEvent {
  const LoadCitySuggestions({
    required this.query,
    required this.langCode,
    this.limit,
  });
  final String query;
  final String langCode;
  final int? limit;

  @override
  List<Object> get props => [query, langCode, limit ?? 5];
}

class ClearCitySuggestion extends CityAutocompleteEvent {}
