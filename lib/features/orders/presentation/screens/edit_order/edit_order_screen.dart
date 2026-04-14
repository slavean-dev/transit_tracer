import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_translator/geo_error_translator.dart';
import 'package:transit_tracer/core/utils/ui/app_snack_bar.dart';
import 'package:transit_tracer/core/widgets/blur_loader/blur_loader.dart';
import 'package:transit_tracer/features/orders/presentation/screens/edit_order/bloc/edit_order_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/presentation/widgets/order_form/order_form.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key, required this.order});

  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => GetIt.I<EditOrderBloc>(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<EditOrderBloc, EditOrderState>(
          listener: (context, state) {
            if (state is EditOrderFailure) {
              if (state.firebaseType != null) {
                final error = ErrorTranslator.translate(
                  context,
                  state.firebaseType,
                );
                if (error != null) {
                  AppSnackBar.showErrorMessage(context, error);
                }
              }
              if (state.geoType != null) {
                final error = GeoErrorTranslator.translate(
                  context,
                  state.geoType,
                );
                if (error != null) {
                  AppSnackBar.showErrorMessage(context, error);
                }
              }
            }
            if (state is StateUpdatePendingLater) {
              context.router.pop();
              AppSnackBar.showOfflineMessage(context);
            }
            if (state is EditOrderSuccessfull) {
              context.router.pop();
              AppSnackBar.showSuccessMessage(context, s.orderEditSuccess);
            }
          },
          child: BlocBuilder<EditOrderBloc, EditOrderState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(title: Text(s.orderEditTitle)),
                    body: Center(
                      child: SingleChildScrollView(
                        child: OrderForm(
                          order: order,
                          title: s.orderEdit,
                          buttonText: s.btnOrderEdit,
                          onSubmit: (form) {
                            context.read<EditOrderBloc>().add(
                              EditOrderData(
                                oldFrom: order.from,
                                oldTo: order.to,
                                fromSuggestion: form.fromSuggestion,
                                toSuggestion: form.toSuggestion,
                                description: form.description,
                                weight: form.weight,
                                price: form.price,
                                uid: form.uid as String,
                                oid: form.oid as String,
                                status: form.isActive as OrderStatus,
                                createdAt: form.createdAt as DateTime,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (state is EditOrderLoading) const BlurLoader(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
