import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/core/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/widgets/blur_loader/blur_loader.dart';
import 'package:transit_tracer/features/orders/bloc/order_details/order_details_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/widgets/order_form/order_form.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key, required this.order});

  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => GetIt.I<OrderDetailsBloc>(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<OrderDetailsBloc, OrderDetailsState>(
          listener: (context, state) {
            if (state is OrderDetailsFailure) {
              final String? error = ErrorTranslator.translate(
                context,
                state.type,
              );
              if (error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error)));
              }
            }
            if (state is StateUpdatePendingLater) {
              context.router.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(Icons.cloud_off_rounded, size: 28),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.offlineModeMessage),
                              Text(s.offlineSaveMessage),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is OrderDataEditedSuccessfull) {
              context.router.pop();
            }
          },
          child: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(title: Text(s.orderEditTitle)),
                    body: Center(
                      child: OrderForm(
                        order: order,
                        title: s.orderEdit,
                        buttonText: s.btnOrderEdit,
                        onSubmit: (form) {
                          context.read<OrderDetailsBloc>().add(
                            EditOrderData(
                              from: form.from,
                              to: form.to,
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
                  if (state is OrderDetailsLoading) const BlurLoader(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
