import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class ArchiveOrdersScreen extends StatelessWidget {
  const ArchiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(S.of(context).archiveTitle)));
  }
}
