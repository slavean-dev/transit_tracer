import 'package:flutter/material.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BaseContainer(
        theme: theme,
        child: Row(
          children: [
            Icon(Icons.wifi_off, color: theme.colorScheme.primary, size: 32),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    s.orderOflineTitle,
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                  Text(
                    s.orderOflineDescription,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
