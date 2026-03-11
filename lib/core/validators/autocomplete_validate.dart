import 'package:flutter/material.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/generated/l10n.dart';

enum CityValidationEror { empty, notSelected, tooShort }

class AutocompleteValidate {
  static CityValidationEror? city(String? v, CitySuggestion? suggestion) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return CityValidationEror.empty;
    if (suggestion == null) return CityValidationEror.notSelected;
    if (value.length < 2) return CityValidationEror.tooShort;
    return null;
  }
}

extension CityValidationErorX on CityValidationEror {
  String toText(BuildContext context) {
    final s = S.of(context);
    return switch (this) {
      CityValidationEror.empty => s.validationCityRequired,
      CityValidationEror.tooShort => s.validationCityTooShort,
      CityValidationEror.notSelected => s.validationSelectFromSuggestion,
    };
  }
}
