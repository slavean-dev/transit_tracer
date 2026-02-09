import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderFormField extends StatelessWidget {
  const OrderFormField({
    super.key,
    required this.theme,
    required this.controller,
    required this.maxLines,
    required this.minLines,
    required this.maxLength,
    required this.label,
    required this.hint,
    required this.validator,
    required this.keyboardType,
    required this.inputFormatters,
    required this.focusNode,
  });

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ThemeData theme;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextFormField(
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            counterText: '',
          ),
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
        ),
      ),
    );
  }
}
