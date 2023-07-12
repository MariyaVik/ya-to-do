import 'package:flutter/material.dart';

import '../../common/theme/other_styles.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  const MyCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: cardShadow()),
        child: child);
  }
}
