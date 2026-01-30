import 'package:flutter/material.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class OurMissionContainer extends StatelessWidget {
  const OurMissionContainer({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: BaseContainer(
        theme: theme,
        child: Column(
          children: [
            Center(
              child: Text(
                S.of(context).ourMissionTitle,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Divider(color: theme.colorScheme.inverseSurface),
            SizedBox(height: 8),
            Text(S.of(context).ourMissionContent),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
