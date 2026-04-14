import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_translator/geo_error_translator.dart';
import 'package:transit_tracer/core/utils/ui/app_snack_bar.dart';
import 'package:transit_tracer/core/widgets/blur_loader/blur_loader.dart';
import 'package:transit_tracer/features/orders/presentation/screens/create_order/bloc/create_order_bloc.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/order_form/order_form.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class CreateOrderScreen extends StatelessWidget {
  CreateOrderScreen({super.key});

  final _orderFormKey = GlobalKey<OrderFormState>();

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocProvider(
      create: (context) => GetIt.I<CreateOrderBloc>(),
      child: BlocListener<CreateOrderBloc, CreateOrderState>(
        listener: (context, state) {
          if (state is CreateOrderFailure) {
            if (state.firebaseType != null) {
              final error =
                  ErrorTranslator.translate(context, state.firebaseType) ?? '';
              AppSnackBar.showErrorMessage(context, error);
            }
            if (state.geoType != null) {
              final error =
                  GeoErrorTranslator.translate(context, state.geoType) ?? '';
              AppSnackBar.showErrorMessage(context, error);
            }
          }
          if (state is CreateOrderSuccess) {
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
        child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
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
                          context.read<CreateOrderBloc>().add(
                            SaveUserOrder(
                              from: value.fromSuggestion,
                              to: value.toSuggestion,
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
                if (state is CreateOrderLoading) const BlurLoader(),
              ],
            );
          },
        ),
      ),
    );
  }
}
