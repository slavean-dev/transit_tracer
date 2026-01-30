import 'package:flutter/material.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';

class OrderFormButton extends StatelessWidget {
  const OrderFormButton({super.key, required this.submit, required this.title});
  final VoidCallback submit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseButton(onPressed: submit, text: title);
  }
}
