import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_translator/geo_error_translator.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/features/city_autocomplete/bloc/city_autocomplete_bloc.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/generated/l10n.dart';

class SuggestionsList extends StatelessWidget {
  const SuggestionsList({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onCitySelected,
    required this.hideOverlay,
  });
  final Function(CitySuggestion) onCitySelected;

  final VoidCallback hideOverlay;

  final TextEditingController controller;
  final FocusNode focusNode;

  void _handleTapOutside(CityAutocompleteState state, BuildContext context) {
    if (!focusNode.hasFocus) return;

    if (state is CityAutocompleteLoaded) {
      controller.text = state.suggestions.first.cityName;
      onCitySelected(state.suggestions.first);
    } else if (state is CityAutocompleteEmpty) {
      controller.clear();
      context.read<CityAutocompleteBloc>().add(ClearCitySuggestion());
    }

    focusNode.unfocus();
    hideOverlay();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<CityAutocompleteBloc, CityAutocompleteState>(
        builder: (context, state) {
          late final Widget child;

          if (state is CityAutocompleteLoading) {
            child = const LinearProgressIndicator();
          }
          if (state is CityAutocompleteLoaded) {
            child = BaseContainer(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = state.suggestions[index];
                  return ListTile(
                    title: Text(suggestion.cityName),
                    onTap: () {
                      controller.text = suggestion.cityName;

                      onCitySelected(suggestion);
                      hideOverlay();
                      focusNode.unfocus();
                    },
                  );
                },
              ),
            );
          }
          if (state is CityAutocompleteEmpty) {
            child = Center(child: Text(s.suggestionListEmpty));
          }
          if (state is CityAutocompleteError) {
            final String error =
                GeoErrorTranslator.translate(context, state.type) ?? '';
            child = Center(child: Text(error));
          }
          return TapRegion(
            onTapOutside: (event) {
              _handleTapOutside(state, context);
            },
            child: child,
          );
        },
      ),
    );
  }
}
