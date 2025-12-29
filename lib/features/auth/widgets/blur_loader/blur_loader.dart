import 'dart:ui';

import 'package:flutter/material.dart';

class BlurLoader extends StatelessWidget {
  const BlurLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
