import 'package:flutter/material.dart';

import '../../common/theme/other_styles.dart';

class MyCard extends StatelessWidget {
  final double marginH;
  final double marginV;
  final Widget? child;
  const MyCard({super.key, this.child, this.marginH = 8, this.marginV = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: cardShadow()),
        child: child);
  }
}
