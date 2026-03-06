import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state is CityAutocompleteLoading) {
            return const LinearProgressIndicator();
          }
          if (state is CityAutocompleteLoaded) {
            return TapRegion(
              onTapOutside: (event) {
                _handleTapOutside(state, context);
              },
              child: BaseContainer(
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
              ),
            );
          }
          if (state is CityAutocompleteEmpty) {
            return Center(child: Text(s.suggestionListEmpty));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
