import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form.dart';

@RoutePage()
class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key, required this.order});

  final OrderData order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Edit order')),
        body: Center(
          child: SingleChildScrollView(
            child: OrderForm(
              title: 'Edit',
              buttonText: 'Edit order',
              onSubmit: (form) {},
            ),
          ),
        ),
      ),
    );
  }
}
