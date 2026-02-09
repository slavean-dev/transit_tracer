import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/app/router/router.dart';

import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/widgets/city_autocomplete_field.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/core/validators/autocomplete_validate.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/transports/widgets/date_field/date_field.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class TransportSearchPage extends StatefulWidget {
  const TransportSearchPage({super.key});

  @override
  State<TransportSearchPage> createState() => _TransportSearchPageState();
}

class _TransportSearchPageState extends State<TransportSearchPage> {
  late final TextEditingController _fromCityController;
  late final TextEditingController _toCityController;

  final FocusNode _fromCityFocusNode = FocusNode();
  final FocusNode _toCityFocusNode = FocusNode();

  CityPoint? fromCity;
  CityPoint? toCity;

  DateTime? _selectedDate;

  @override
  void initState() {
    _fromCityController = TextEditingController();
    _toCityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fromCityController.dispose();
    _toCityController.dispose();
    super.dispose();
  }

  void _swapCities() {
    setState(() {
      final city = _toCityController.text;
      _toCityController.text = _fromCityController.text;
      _fromCityController.text = city;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      helpText: 'Select date',
      cancelText: 'Cancel',
      confirmText: 'Ok',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String get _dateLable {
    final now = DateTime.now();
    if (_selectedDate == null) {
      return '${now.day.toString().padLeft(2, '0')}.'
          '${now.month.toString().padLeft(2, '0')}.'
          '${now.year}';
    }
    final d = _selectedDate!;
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.'
        '${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).searchTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BaseContainer(
            theme: theme,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      S.of(context).search,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CityAutocompleteField(
                    enabled: true,
                    focusNode: _fromCityFocusNode,
                    onChanged: (_) => fromCity = null,
                    validator: (v) => AutocompleteValidate.city(v, fromCity),

                    title: S.of(context).fieldFrom,
                    controller: _fromCityController,
                    theme: theme,
                  ),
                  IconButton(
                    onPressed: () {
                      _swapCities();
                    },
                    icon: const Icon(Icons.swap_vert),
                  ),
                  CityAutocompleteField(
                    enabled: true,
                    focusNode: _toCityFocusNode,
                    onChanged: (_) => toCity = null,
                    validator: (v) => AutocompleteValidate.city(v, toCity),

                    title: S.of(context).fieldTo,
                    controller: _toCityController,
                    theme: theme,
                  ),
                  const SizedBox(height: 6),
                  DateField(
                    title: S.of(context).dateLabel,
                    theme: theme,
                    dateLable: _dateLable,
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 16),
                  BaseButton(
                    onPressed: () {
                      final from = _fromCityController.text;
                      final to = _toCityController.text;
                      context.router.push(
                        TransportResultsRoute(
                          frome: cityCutter(from),
                          to: cityCutter(to),
                          date: _dateLable,
                        ),
                      );
                    },
                    text: S.of(context).search,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
