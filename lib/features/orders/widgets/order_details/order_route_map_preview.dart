import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/core/services/network_service/network_service.dart';

import 'package:transit_tracer/core/utils/mappers/polyline_decode.dart';
import 'package:transit_tracer/core/utils/maps/static_map_url.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
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
  bool _isLoading = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _buildUrl();
  }

  @override
  void didUpdateWidget(covariant OrderRouteMapPreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    final coordsChanged =
        oldWidget.order.from.lat != widget.order.from.lat ||
        oldWidget.order.from.lng != widget.order.from.lng ||
        oldWidget.order.to.lat != widget.order.to.lat ||
        oldWidget.order.to.lng != widget.order.to.lng;

    if (coordsChanged) {
      _buildUrl();
    }
  }

  Future<void> _buildUrl() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    final connectivity = GetIt.I<NetworkService>();
    final svc = GetIt.I<GoogleRouteService>();
    final apiKey = GetIt.I<EnvService>().autocompleteApiKey;

    final hasInternet = await connectivity.isConnected;

    if (!hasInternet) {
      if (mounted) {
        setState(() {
          _url = null;
          _isLoading = false;
          _isInitialized = true;
        });
      }
      return;
    }

    try {
      final encoded = await svc.fetchEncodedPolyline(
        fromLat: widget.order.from.lat,
        fromLng: widget.order.from.lng,
        toLat: widget.order.to.lat,
        toLng: widget.order.to.lng,
      );

      if (!mounted) return;

      String newUrl;
      if (encoded != null) {
        final pts = decodePolyline(encoded);
        newUrl = StaticMapUrl.buildRouteByRoads(
          apiKey: apiKey,
          fromLat: widget.order.from.lat,
          fromLng: widget.order.from.lng,
          toLat: widget.order.to.lat,
          toLng: widget.order.to.lng,
          pathPoints: pts,
        );
      } else {
        newUrl = StaticMapUrl.buildRoutePreview(
          apiKey: apiKey,
          fromLat: widget.order.from.lat,
          fromLng: widget.order.from.lng,
          toLat: widget.order.to.lat,
          toLng: widget.order.to.lng,
        );
      }

      setState(() {
        _url = newUrl;
        _isLoading = false;
        _isInitialized = true;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 16 / 6,
        child: Container(
          color: widget.theme.colorScheme.surface,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (!_isInitialized || _isLoading) {
      return _buildLoading();
    }

    if (_url == null) {
      return _buildOfflineError();
    }

    return CachedNetworkImage(
      imageUrl: _url!,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildLoading(),
      errorWidget: (context, url, error) => _buildOfflineError(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: widget.theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildOfflineError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.map_outlined,
          color: widget.theme.colorScheme.onSurfaceVariant,
          size: 32,
        ),
        const SizedBox(height: 4),
        Text(
          'Map unavailable offline',
          style: widget.theme.textTheme.bodySmall?.copyWith(
            color: widget.theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: _buildUrl,
          style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
