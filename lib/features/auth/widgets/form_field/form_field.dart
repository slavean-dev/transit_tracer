import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.hint,
    required this.validator,
    required this.type,
    required this.obscureText,
    required this.suffixIcon,
    required this.onChange,
    required this.controller,
    required this.theme,
    this.externalError,
    this.prefix,
    this.maxLength,
  });
  final String hint;
  final FormFieldValidator<String> validator;
  final TextInputType type;
  final bool obscureText;
  final IconButton? suffixIcon;
  final ValueChanged<String>? onChange;
  final TextEditingController controller;
  final ThemeData theme;
  final String? externalError;
  final String? prefix;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: TextFormField(
          maxLength: maxLength,

          controller: controller,
          onChanged: onChange,
          obscureText: obscureText,
          keyboardType: type,
          validator: validator,
          decoration: InputDecoration(
            counterText: '',
            labelText: hint,
            prefixText: prefix,
            prefixStyle: theme.textTheme.bodyLarge,
            //hintStyle: TextStyle(color: Theme.of(context).hintColor),
            //hint: Text(hint),
            suffixIcon: suffixIcon,
            errorText: externalError,
          ),
        ),
      ),
    );
  }
}
