import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/widgets/city_autocomplete_field.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/validators/autocomplete_validate.dart';
import 'package:transit_tracer/core/validators/order_validators.dart';
import 'package:transit_tracer/features/auth/widgets/blur_loader/blur_loader.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/models/order_form_data/order_form_data.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_description_form_field/order_description_form_field.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form_button/order_form_button.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form_field/order_form_field.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/weight_picker/weight_picker.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({
    super.key,
    required this.onSubmit,
    required this.title,
    required this.buttonText,
  });

  final ValueChanged<OrderFormData> onSubmit;

  final String title;

  final String buttonText;

  @override
  State<OrderForm> createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  late TextEditingController _fromCityController;

  late TextEditingController _toCityController;

  final TextEditingController _descriptionController = TextEditingController();

  WeightRange? weight;

  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CityPoint? fromCity;
  CityPoint? toCity;

  int _autoEpoch = 0;

  @override
  void initState() {
    _fromCityController = TextEditingController();
    _toCityController = TextEditingController();
    super.initState();
  }

  void _swapCities() {
    setState(() {
      final city = _toCityController.text;
      final cityId = fromCity;
      fromCity = toCity;
      toCity = cityId;
      _toCityController.text = _fromCityController.text;
      _fromCityController.text = city;
    });
  }

  void resetFormAfterSuccess() {
    FocusManager.instance.primaryFocus?.unfocus();

    _formKey.currentState!.reset();
    _fromCityController = TextEditingController();
    _toCityController = TextEditingController();
    _descriptionController.clear();
    _priceController.clear();
    setState(() {
      fromCity = null;
      toCity = null;
      weight = null;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _autoEpoch++;
      });
    });
  }

  @override
  void dispose() {
    _fromCityController.dispose();
    _toCityController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final S s = S.of(context);
    return Form(
      key: _formKey,
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: BaseContainer(
                  theme: theme,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          widget.title,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(height: 8),
                      CityAutocompleteField(
                        onPredictionWithCoordinatesReceived: (prediction) {
                          final placeId = prediction.placeId;
                          if (placeId == null || placeId.isEmpty) {
                            return;
                          }

                          final lat = NumUtils().toDouble(prediction.lat);
                          final lng = NumUtils().toDouble(prediction.lng);

                          if (lat == null || lng == null) {
                            return;
                          }

                          setState(() {
                            fromCity = CityPoint(
                              name: _fromCityController.text,
                              placeId: placeId,
                              lat: lat,
                              lng: lng,
                            );
                          });
                        },
                        key: ValueKey('from_$_autoEpoch'),
                        onChanged: (_) => fromCity = null,
                        validator: (v) =>
                            AutocompleteValidate.city(v, fromCity),

                        title: s.fromFormLable,
                        controller: _fromCityController,
                        theme: theme,
                      ),

                      Center(
                        child: IconButton(
                          onPressed: () => _swapCities(),
                          icon: const Icon(Icons.swap_vert),
                        ),
                      ),
                      CityAutocompleteField(
                        onPredictionWithCoordinatesReceived: (prediction) {
                          final placeId = prediction.placeId;
                          if (placeId == null || placeId.isEmpty) {
                            return;
                          }

                          final lat = NumUtils().toDouble(prediction.lat);
                          final lng = NumUtils().toDouble(prediction.lng);

                          if (lat == null || lng == null) {
                            return;
                          }

                          setState(() {
                            toCity = CityPoint(
                              name: _toCityController.text,
                              placeId: placeId,
                              lat: lat,
                              lng: lng,
                            );
                          });
                        },
                        key: ValueKey('to_$_autoEpoch'),
                        onChanged: (_) => toCity = null,
                        validator: (v) => AutocompleteValidate.city(v, toCity),
                        title: s.toFormLable,
                        controller: _toCityController,
                        theme: theme,
                      ),
                      SizedBox(height: 16),
                      OrderDescriptionFormField(
                        theme: theme,
                        descriptionController: _descriptionController,
                        s: s,
                      ),
                      SizedBox(height: 16),
                      WeightPicker(
                        onSaved: (newValue) => weight = newValue!,
                        validator: (v) => OrderValidators.weight(v),
                        theme: theme,
                        onChange: (newValue) => weight = newValue,
                      ),
                      SizedBox(height: 16),
                      OrderFormField(
                        validator: (value) => OrderValidators.price(value),
                        theme: theme,
                        controller: _priceController,
                        maxLines: 1,
                        minLines: 1,
                        maxLength: 50,
                        label: s.priceFormLable,
                        hint: s.priceFormHint,
                      ),
                      SizedBox(height: 16),
                      OrderFormButton(
                        title: widget.buttonText,
                        submit: () {
                          if (_formKey.currentState!.validate()) {
                            if (fromCity == null ||
                                toCity == null ||
                                weight == null) {
                              return;
                            }
                            widget.onSubmit(
                              OrderFormData(
                                from: fromCity!,
                                to: toCity!,
                                description: _descriptionController.text,
                                weight: weight!,
                                price: _priceController.text,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              if (state is OrdersLoading) const BlurLoader(),
            ],
          );
        },
      ),
    );
  }
}
