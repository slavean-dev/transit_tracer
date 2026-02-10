import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/utils/ui/app_dialog.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/widgets/city_autocomplete_field.dart';
import 'package:transit_tracer/core/utils/formatters/num_utils.dart';
import 'package:transit_tracer/core/validators/autocomplete_validate.dart';
import 'package:transit_tracer/core/validators/order_validators.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_form_data/order_form_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/no_internet_banner/no_internet_banner.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_description_form_field/order_description_form_field.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form_field/order_form_field.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/weight_picker/weight_picker.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({
    super.key,
    required this.onSubmit,
    required this.title,
    required this.buttonText,
    this.order,
  });

  final OrderData? order;

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

  final FocusNode _fromCityFocusNode = FocusNode();

  final FocusNode _toCityFocusNode = FocusNode();

  final FocusNode _descriptionFocusNode = FocusNode();

  final FocusNode _priceFocusNode = FocusNode();

  final FocusNode _weightFocus = FocusNode();

  CityPoint? fromCity;
  CityPoint? toCity;

  int _autoEpoch = 0;

  bool get _isChanged {
    if (widget.order == null) {
      return true;
    }
    final order = widget.order!;
    return fromCity?.placeId != order.from.placeId ||
        toCity?.placeId != order.to.placeId ||
        _descriptionController.text != order.description ||
        weight != order.weight ||
        _priceController.text != order.price;
  }

  bool get _isEditing {
    return widget.order != null;
  }

  @override
  void initState() {
    _fromCityController = TextEditingController();
    _toCityController = TextEditingController();

    if (widget.order != null) {
      _fromCityController.text = widget.order!.from.name;
      _toCityController.text = widget.order!.to.name;
      _descriptionController.text = widget.order!.description;
      _priceController.text = widget.order!.price;
      fromCity = widget.order!.from;
      toCity = widget.order!.to;
      weight = widget.order!.weight;
    }

    _descriptionController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));

    _fromCityController.addListener(() => setState(() {}));
    _toCityController.addListener(() => setState(() {}));
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

  void _scrollToError(FocusNode focusNode) {
    focusNode.requestFocus();
    if (focusNode.context != null) {
      Scrollable.ensureVisible(
        focusNode.context!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
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
    final isOnline = context.select((SettingsCubit c) => c.state.isOnline);
    final isButtonEnabled = (isOnline || _isEditing) && _isChanged;
    return PopScope(
      canPop: !_isChanged,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        bool shouldPop = false;

        await AppDialog.showConfirm(
          context,
          title: s.dialogConfirmExitTitle,
          message: s.dialogConfirmExitMessage,
          confirmText: s.dialogExitConfirm,
          onConfirm: () {
            shouldPop = true;
          },
        );

        if (shouldPop && context.mounted) {
          Navigator.of(context).pop(result);
        } else {
          setState(() {});
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: !isOnline
                    ? const NoInternetBanner()
                    : const SizedBox.shrink(),
              ),

              BaseContainer(
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
                    const SizedBox(height: 8),
                    CityAutocompleteField(
                      enabled: isOnline,
                      focusNode: _fromCityFocusNode,
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
                      validator: (v) => AutocompleteValidate.city(v, fromCity),

                      title: s.fieldFrom,
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
                      enabled: isOnline,
                      focusNode: _toCityFocusNode,
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
                      title: s.fieldTo,
                      controller: _toCityController,
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    OrderDescriptionFormField(
                      descriptionFocusNode: _descriptionFocusNode,
                      theme: theme,
                      descriptionController: _descriptionController,
                    ),
                    const SizedBox(height: 16),
                    WeightPicker(
                      focusNode: _weightFocus,
                      initialValue: widget.order?.weight,
                      onSaved: (newValue) => weight = newValue!,
                      validator: (v) => OrderValidators.weight(v),
                      theme: theme,
                      onChange: (newValue) => setState(() {
                        weight = newValue;
                      }),
                    ),
                    const SizedBox(height: 16),
                    OrderFormField(
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) => OrderValidators.price(value),
                      theme: theme,
                      controller: _priceController,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: 50,
                      label: s.orderFieldPrice,
                      hint: s.orderFieldPriceHint,
                    ),
                    const SizedBox(height: 16),
                    BaseButton(
                      text: widget.buttonText,
                      onPressed: !isButtonEnabled
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();

                              final bool isFormValid = _formKey.currentState!
                                  .validate();

                              if (!isFormValid ||
                                  fromCity == null ||
                                  toCity == null ||
                                  weight == null) {
                                if (fromCity == null) {
                                  _scrollToError(_fromCityFocusNode);
                                } else if (toCity == null) {
                                  _scrollToError(_toCityFocusNode);
                                } else if (!_formKey.currentState!.validate()) {
                                  if (_descriptionController.text.isEmpty) {
                                    _scrollToError(_descriptionFocusNode);
                                  } else if (_priceController.text.isEmpty) {
                                    _scrollToError(_priceFocusNode);
                                  }
                                } else if (weight == null) {
                                  _scrollToError(_weightFocus);
                                }
                                return;
                              }
                              widget.onSubmit(
                                OrderFormData(
                                  widget.order?.uid,
                                  widget.order?.oid,
                                  widget.order?.status,
                                  widget.order?.createdAt,
                                  from: fromCity!,
                                  to: toCity!,
                                  description: _descriptionController.text,
                                  weight: weight!,
                                  price: _priceController.text,
                                ),
                              );
                            },
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
