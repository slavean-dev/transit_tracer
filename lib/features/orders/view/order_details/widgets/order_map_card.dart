import 'package:flutter/material.dart';
import 'package:transit_tracer/core/utils/map_launcher.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/widgets/action_button/action_button.dart';
import 'package:transit_tracer/features/orders/widgets/order_route_map_preview/order_route_map_preview.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OrderMapCard extends StatelessWidget {
  const OrderMapCard({super.key, required this.theme, required this.order});

  final ThemeData theme;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          OrderRouteMapPreview(theme: theme, order: order),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: ActionButton(
                theme: theme,
                lable: s.btnOpenInMap,
                textColor: Colors.black,
                backgroundColor: theme.primaryColor,
                onPressed: () => openRouteInGoogleMaps(
                  fromLat: order.from.lat,
                  fromLng: order.from.lng,
                  toLat: order.to.lat,
                  toLng: order.to.lng,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
