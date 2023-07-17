import 'package:flutter/material.dart';

import '../../common/utils.dart';
import 'widgets/language_settings_group.dart';
import 'widgets/settings_header.dart';
import 'widgets/theme_settings_group.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: Delegate(maxHeight: 56, minHeight: 56)),
          const SliverToBoxAdapter(
            child: LanguageSettingGroup(),
          ),
          const SliverToBoxAdapter(
            child: ThemeSettingGroup(),
          ),
        ],
      ),
    ));
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  Delegate({
    required this.maxHeight,
    required this.minHeight,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double optimShrinkOffset =
        normalizeDouble(0, maxExtent, 0, 1, shrinkOffset);
    return SettingsHeader(optimShrinkOffset: optimShrinkOffset);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
