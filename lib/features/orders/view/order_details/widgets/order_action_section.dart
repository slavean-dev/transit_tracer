import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/utils/app_dialog.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/features/orders/bloc/order_details/order_details_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/widgets/action_button/action_button.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderActionSection extends StatelessWidget {
  const OrderActionSection({
    super.key,
    required this.order,
    required this.theme,
  });

  final OrderData order;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        BaseButton(
          onPressed: () {
            context.router.push(EditOrderRoute(order: order));
          },
          text: s.btnOrderEdit,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ActionButton(
                theme: theme,
                lable: s.btnOrderArchive,
                textColor: null,
                backgroundColor: theme.colorScheme.surface,
                onPressed: () {
                  AppDialog.showConfirm(
                    context,
                    title: s.dialogAtchiveTitle,
                    message: s.dialogAtchiveMessage,
                    confirmText: s.dialogAtchiveConfirm,
                    onConfirm: () {
                      context.read<OrderDetailsBloc>().add(
                        ArchiveOrder(oid: order.oid),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: ActionButton(
                lable: s.btnOrderDelete,
                theme: theme,
                textColor: Colors.red,
                backgroundColor: theme.colorScheme.surface,
                onPressed: () {
                  AppDialog.showConfirm(
                    context,
                    title: s.dialogDeleteTitle,
                    message: s.dialogDeleteMessage,
                    confirmText: s.dialogDeleteConfirm,
                    onConfirm: () {
                      context.read<OrderDetailsBloc>().add(
                        DeleteUserOrder(oid: order.oid),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
