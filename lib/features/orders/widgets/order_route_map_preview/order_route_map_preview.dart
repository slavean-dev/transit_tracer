import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:transit_tracer/core/utils/polyline_decode.dart';
import 'package:transit_tracer/core/utils/static_map_url.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/core/services/env_service/env_service.dart';
import 'package:transit_tracer/core/services/google_route_service/google_route_service.dart';

class OrderRouteMapPreview extends StatefulWidget {
  const OrderRouteMapPreview({
    super.key,
    required this.theme,
    required this.order,
  });

  final ThemeData theme;
  final OrderData order;

  @override
  State<OrderRouteMapPreview> createState() => _OrderRouteMapPreviewState();
}

class _OrderRouteMapPreviewState extends State<OrderRouteMapPreview> {
  String? _url;

  @override
  void initState() {
    super.initState();
    _buildUrl();
  }

  Future<void> _buildUrl() async {
    final svc = GetIt.I<GoogleRouteService>();
    final apiKey = GetIt.I<EnvService>().autocompleteApiKey;

    final encoded = await svc.fetchEncodedPolyline(
      fromLat: widget.order.from.lat,
      fromLng: widget.order.from.lng,
      toLat: widget.order.to.lat,
      toLng: widget.order.to.lng,
    );

    if (!mounted) return;

    if (encoded == null) {
      setState(() {
        _url = StaticMapUrl.buildRoutePreview(
          apiKey: apiKey,
          fromLat: widget.order.from.lat,
          fromLng: widget.order.from.lng,
          toLat: widget.order.to.lat,
          toLng: widget.order.to.lng,
        );
      });
      return;
    }

    final pts = decodePolyline(encoded);

    setState(() {
      _url = StaticMapUrl.buildRouteByRoads(
        apiKey: apiKey,
        fromLat: widget.order.from.lat,
        fromLng: widget.order.from.lng,
        toLat: widget.order.to.lat,
        toLng: widget.order.to.lng,
        pathPoints: pts,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_url == null) {
      return SizedBox(
        height: 140,
        child: Center(
          child: CircularProgressIndicator(
            color: widget.theme.colorScheme.primary,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 16 / 6,
        child: Image.network(_url!, fit: BoxFit.cover),
      ),
    );
  }
}
