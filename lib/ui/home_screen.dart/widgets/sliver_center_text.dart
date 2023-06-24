import 'package:flutter/material.dart';

class SliverCenterWidget extends StatelessWidget {
  final Widget child;
  const SliverCenterWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: child),
    );
  }
}
