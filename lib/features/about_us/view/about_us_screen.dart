import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/features/about_us/widgets/about_app_container/about_app_container.dart';
import 'package:transit_tracer/features/about_us/widgets/about_header_card/about_header_card.dart';
import 'package:transit_tracer/features/about_us/widgets/contacts_container/contacts_container.dart';
import 'package:transit_tracer/features/about_us/widgets/our_mission_container/our_mission_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).aboutUsTitle)),
      body: Center(
        child: Column(
          children: [
            AboutHeaderCard(theme: theme),
            AboutAppContainer(theme: theme),
            OurMissionContainer(theme: theme),
            ContactsContainer(theme: theme),
          ],
        ),
      ),
    );
  }
}
