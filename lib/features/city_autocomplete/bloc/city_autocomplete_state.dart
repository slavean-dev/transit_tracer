part of 'city_autocomplete_bloc.dart';

class CityAutocompleteState extends Equatable {
  const CityAutocompleteState();

  @override
  List<Object> get props => [];
}

class CityAutocompleteInitial extends CityAutocompleteState {}

class CityAutocompleteLoading extends CityAutocompleteState {}

class CityAutocompleteLoaded extends CityAutocompleteState {
  const CityAutocompleteLoaded({required this.suggestions});
  final List<CitySuggestion> suggestions;

  @override
  List<List<CitySuggestion>> get props => [suggestions];
}

class CityAutocompleteEmpty extends CityAutocompleteState {}

class CityAutocompleteError extends CityAutocompleteState {
  const CityAutocompleteError({required this.type, required this.error});
  final GeoErrorType type;
  final String? error;

  @override
  List<Object> get props => [error ?? '', type];
}
