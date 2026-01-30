import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/utils/num_utils.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.theme, required this.order});

  final OrderData order;
  final ThemeData theme;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isHighlighted = false;

  @override
  void initState() {
    super.initState();
    final age = DateTime.now().difference(widget.order.createdAt).inSeconds;
    if (age < 5) {
      _isHighlighted = true;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isHighlighted = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
      child: GestureDetector(
        onTap: () => context.router.push(
          OrderDetailsRoute(oid: widget.order.oid, initialData: widget.order),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 1500),
          tween: ColorTween(
            begin: _isHighlighted
                ? widget.theme.primaryColor.withAlpha(80)
                : widget.theme.colorScheme.surface,
            end: widget.theme.colorScheme.surface,
          ),
          builder: (context, color, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: widget.theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: cityCutter(widget.order.from.name),
                            style: widget.theme.textTheme.titleMedium,
                          ),
                          TextSpan(
                            text: '→',
                            style: widget.theme.textTheme.titleLarge?.copyWith(
                              color: widget.theme.colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: cityCutter(widget.order.to.name),
                            style: widget.theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cargo:'),
                              Text(
                                widget.order.description,
                                style: widget.theme.textTheme.bodySmall
                                    ?.copyWith(
                                      color: widget
                                          .theme
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '₴ ${NumUtils().priceFormater(widget.order.price)}',
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                      color: widget.theme.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.theme.primaryColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              child: Text(
                                'More ›',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
