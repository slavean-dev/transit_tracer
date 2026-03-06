import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/core/widgets/base_form_field_container/base_form_field_container.dart';
import 'package:transit_tracer/features/city_autocomplete/bloc/city_autocomplete_bloc.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/city_autocomplete/widget/suggestion_list.dart';

class CustomAutocompleteCity extends StatefulWidget {
  const CustomAutocompleteCity({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onCitySelected,
    required this.lable,
    this.validator,
    this.enabled,
    this.onChanged,
  });

  final Function(CitySuggestion) onCitySelected;

  final TextEditingController controller;
  final FocusNode focusNode;

  final bool? enabled;

  final String lable;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<CustomAutocompleteCity> createState() => _CustomAutocompleteCityState();
}

class _CustomAutocompleteCityState extends State<CustomAutocompleteCity> {
  late final CityAutocompleteBloc _bloc;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce;

  @override
  void initState() {
    _bloc = GetIt.I<CityAutocompleteBloc>();
    widget.controller.addListener(() {
      _handleControllerChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    _hideOverlay();
    _debounce?.cancel();
    super.dispose();
  }

  void _handleControllerChange() {
    if (widget.controller.text.isEmpty) {
      _bloc.add(ClearCitySuggestion());
      _hideOverlay();
      if (mounted) setState(() {});
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final size = _getWidgetSize();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
          child: BlocProvider.value(
            value: _bloc,
            child: SuggestionsList(
              hideOverlay: _hideOverlay,
              controller: widget.controller,
              focusNode: widget.focusNode,
              onCitySelected: widget.onCitySelected,
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Size _getWidgetSize() {
    final renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }

  void _onSearchChanged(String query, String langCode) {
    if (!widget.focusNode.hasFocus) return;

    if (query.length < 3) return;

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.controller.text.length < 3) {
        _hideOverlay();
        return;
      }
      _bloc.add(LoadCitySuggestions(query: query, langCode: langCode));
      _showOverlay(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = Localizations.localeOf(context).languageCode;
    return BlocBuilder<CityAutocompleteBloc, CityAutocompleteState>(
      bloc: _bloc,
      builder: (context, state) {
        return CompositedTransformTarget(
          link: _layerLink,
          child: BaseFormFieldContainer(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: widget.enabled,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      labelText: widget.lable,
                      counterText: '',
                    ),
                    validator: widget.validator,
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      widget.onChanged?.call(value);
                      _onSearchChanged(value, currentLang);
                    },
                  ),
                ),
                widget.controller.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          widget.controller.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
