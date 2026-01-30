import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/widgets/blur_loader/blur_loader.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class CreateOrderScreen extends StatelessWidget {
  CreateOrderScreen({super.key});

  final _orderFormKey = GlobalKey<OrderFormState>();

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is OrderSavedSuccessfull) {
          _orderFormKey.currentState?.resetFormAfterSuccess();
          context.router.replaceAll([
            const HomeRoute(
              children: [
                OrdersListTabRouter(children: [OrdersListRoute()]),
              ],
            ),
          ]);
        }
      },
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(title: Text(s.createTitle)),
                body: Center(
                  child: SingleChildScrollView(
                    child: OrderForm(
                      title: s.create,
                      buttonText: s.createTitle,
                      key: _orderFormKey,
                      onSubmit: (value) {
                        context.read<OrdersBloc>().add(
                          SaveUserOrder(
                            from: value.from,
                            to: value.to,
                            description: value.description,
                            weight: value.weight,
                            price: value.price,
                          ),
                        );
                      },
                    ),
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
