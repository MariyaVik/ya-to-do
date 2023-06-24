import 'package:flutter/material.dart';

class SliverCenterText extends StatelessWidget {
  final String text;
  const SliverCenterText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: Text(text)),
    );
  }
}
