import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/city_autocomplete/data/repository/abstract_autocomplete_repository.dart';

part 'city_autocomplete_event.dart';
part 'city_autocomplete_state.dart';

class CityAutocompleteBloc
    extends Bloc<CityAutocompleteEvent, CityAutocompleteState> {
  final AbstractAutocompleteRepository repository;

  CityAutocompleteBloc(this.repository) : super(CityAutocompleteInitial()) {
    on<LoadCitySuggestions>(_loadCitySuggestions);
    on<ClearCitySuggestion>(_clearCitySuggestions);
  }

  void _loadCitySuggestions(
    LoadCitySuggestions event,
    Emitter<CityAutocompleteState> emit,
  ) async {
    try {
      emit(CityAutocompleteLoading());
      final suggestion = await repository.getSuggestions(
        event.query,
        event.langCode,
      );
      if (suggestion.isEmpty) {
        emit(CityAutocompleteEmpty());
        return;
      }
      emit(CityAutocompleteLoaded(suggestions: suggestion));
    } catch (e) {
      emit(CityAutocompleteError(error: e.toString()));
    }
  }

  void _clearCitySuggestions(
    ClearCitySuggestion event,
    Emitter<CityAutocompleteState> emit,
  ) {
    emit(CityAutocompleteInitial());
  }
}
