import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../common/utils.dart';
import '../../mobx/state.dart';
import 'widgets/settings_header.dart';

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
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var locale = AppLocalizations.supportedLocales[index];
                return Observer(builder: (context) {
                  return ListTile(
                    title: Text(lookupAppLocalizations(locale).language),
                    subtitle: Text(lookupAppLocalizations(locale).language_en),
                    onTap: () {
                      Provider.of<AppState>(context, listen: false)
                          .changeLocale(locale);
                    },
                    selected:
                        Provider.of<AppState>(context).currentLocale == locale,
                  );
                });
              },
              itemCount: AppLocalizations.supportedLocales.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
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
        normalizationDouble(0, maxExtent, 0, 1, shrinkOffset);
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
