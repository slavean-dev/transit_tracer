import 'package:flutter/material.dart';
import 'package:transit_tracer/core/validators/order_validators.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form_field/order_form_field.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderDescriptionFormField extends StatelessWidget {
  const OrderDescriptionFormField({
    super.key,
    required this.theme,
    required TextEditingController descriptionController,
    required FocusNode descriptionFocusNode,
  }) : _descriptionController = descriptionController,
       _descriptionFocusNode = descriptionFocusNode;

  final ThemeData theme;
  final TextEditingController _descriptionController;
  final FocusNode _descriptionFocusNode;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return OrderFormField(
      focusNode: _descriptionFocusNode,
      keyboardType: null,
      inputFormatters: null,
      validator: (value) => OrderValidators.description(value),
      theme: theme,
      controller: _descriptionController,
      label: s.orderFieldCargo,
      hint: s.orderFieldCargoHint,
      maxLength: 200,
      maxLines: 4,
      minLines: 3,
    );
  }
}
