import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../common/theme/other_styles.dart';

class SettingsHeader extends StatelessWidget {
  final double optimShrinkOffset;
  const SettingsHeader({super.key, required this.optimShrinkOffset});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: headerShadow(optimShrinkOffset)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      log('BACK TO HOME');
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close)),
              ],
            )));
  }
}
