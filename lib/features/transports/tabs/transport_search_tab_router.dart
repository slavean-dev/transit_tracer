import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'TransportSearchTabRouter')
class TransportSearchTabPage extends StatelessWidget {
  const TransportSearchTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
