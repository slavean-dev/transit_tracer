import 'package:flutter/material.dart';
import 'package:transit_tracer/core/constants/assets_path.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class AboutHeaderCard extends StatelessWidget {
  const AboutHeaderCard({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: BaseContainer(
        theme: theme,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage(AssetsPath.transitTracerLogo),
                width: 120,
                height: 120,
              ),
            ),
            Text(
              S.of(context).transitTracerTitle,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(S.of(context).aboutSubtitle, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
