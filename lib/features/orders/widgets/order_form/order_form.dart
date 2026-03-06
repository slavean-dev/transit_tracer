import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/utils/ui/app_dialog.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/core/validators/autocomplete_validate.dart';
import 'package:transit_tracer/core/validators/order_validators.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/city_autocomplete/widget/custom_autocomplete_city.dart';
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
  final TextEditingController _fromCityController = TextEditingController();

  final TextEditingController _toCityController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  WeightRange? weight;

  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _fromCityFocusNode = FocusNode();

  final FocusNode _toCityFocusNode = FocusNode();

  final FocusNode _descriptionFocusNode = FocusNode();

  final FocusNode _priceFocusNode = FocusNode();

  final FocusNode _weightFocus = FocusNode();

  CitySuggestion? fromSuggestion;
  CitySuggestion? toSuggestion;

  bool get _isChanged {
    if (widget.order == null) {
      return true;
    }
    final order = widget.order!;
    return fromSuggestion?.placeId != order.from.placeId ||
        toSuggestion?.placeId != order.to.placeId ||
        _descriptionController.text != order.description ||
        weight != order.weight ||
        _priceController.text != order.price;
  }

  bool get _isEditing {
    return widget.order != null;
  }

  @override
  void initState() {
    if (widget.order != null) {
      _fromCityController.text = widget.order!.from.name;
      _toCityController.text = widget.order!.to.name;
      _descriptionController.text = widget.order!.description;
      _priceController.text = widget.order!.price;
      fromSuggestion = CitySuggestion(
        cityName: widget.order!.from.name,
        placeId: widget.order!.from.placeId,
      );
      toSuggestion = CitySuggestion(
        cityName: widget.order!.to.name,
        placeId: widget.order!.to.placeId,
      );
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
      final tempSuggestion = fromSuggestion;
      fromSuggestion = toSuggestion;
      toSuggestion = tempSuggestion;
      _toCityController.text = _fromCityController.text;
      _fromCityController.text = city;
    });
  }

  void resetFormAfterSuccess() {
    FocusManager.instance.primaryFocus?.unfocus();

    _formKey.currentState!.reset();
    _fromCityController.clear();
    _toCityController.clear();
    _descriptionController.clear();
    _priceController.clear();

    setState(() {
      fromSuggestion = null;
      toSuggestion = null;
      weight = null;
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
                    CustomAutocompleteCity(
                      controller: _fromCityController,
                      focusNode: _fromCityFocusNode,
                      lable: s.fieldFrom,
                      enabled: isOnline,
                      validator: (v) =>
                          AutocompleteValidate.city(v, fromSuggestion),
                      onChanged: (_) => fromSuggestion = null,
                      onCitySelected: (value) {
                        fromSuggestion = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: IconButton(
                        onPressed: () => _swapCities(),
                        icon: const Icon(Icons.swap_vert),
                      ),
                    ),
                    CustomAutocompleteCity(
                      controller: _toCityController,
                      focusNode: _toCityFocusNode,
                      onChanged: (_) => toSuggestion = null,
                      onCitySelected: (value) {
                        toSuggestion = value;
                      },
                      lable: s.fieldTo,
                      enabled: isOnline,
                      validator: (v) =>
                          AutocompleteValidate.city(v, toSuggestion),
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
                                  fromSuggestion == null ||
                                  toSuggestion == null ||
                                  weight == null) {
                                if (fromSuggestion == null) {
                                  _scrollToError(_fromCityFocusNode);
                                } else if (toSuggestion == null) {
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

                                  fromSuggestion: fromSuggestion!,
                                  toSuggestion: toSuggestion!,
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
