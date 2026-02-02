import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/core/services/env_service/env_service.dart';

class CityAutocompleteField extends StatelessWidget {
  const CityAutocompleteField({
    super.key,
    required this.title,
    required this.controller,
    required this.theme,
    required this.onChanged,
    this.validator,
    this.onPredictionWithCoordinatesReceived,
  });

  final String title;
  final TextEditingController controller;
  final ThemeData theme;

  final ValueChanged<Prediction>? onPredictionWithCoordinatesReceived;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final apiKey = GetIt.I<EnvService>().autocompleteApiKey;
    final locale = Localizations.localeOf(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GooglePlacesAutoCompleteTextFormField(
          onPredictionWithCoordinatesReceived:
              onPredictionWithCoordinatesReceived,
          validator: validator,
          maxLines: 1,
          textEditingController: controller,
          config: GoogleApiConfig(
            apiKey: apiKey,
            countries: const ['ua'],
            languageCode: locale.languageCode,
            fetchPlaceDetailsWithCoordinates: true,
            debounceTime: 800,
            placeTypeRestriction: PlaceType.city,
          ),

          decoration: InputDecoration(
            labelText: title,
            hintText: S.of(context).hintEnterCity,
          ),

          onSuggestionClicked: (prediction) {
            final desc = prediction.description ?? '';
            controller.text = desc;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: desc.length),
            );
            FocusScope.of(context).unfocus();
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
