import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../mobx/state.dart';
import '../../common/my_card.dart';

class ThemeSettingGroup extends StatelessWidget {
  const ThemeSettingGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            AppLocalizations.of(context).theme_setting,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        MyCard(
          child: Observer(builder: (context) {
            return ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).light_theme),
                  onTap: () {
                    Provider.of<AppState>(context, listen: false)
                        .changeTheme(isDark: false);
                  },
                  selected: !Provider.of<AppState>(context).isDark,
                ),
                const Divider(),
                ListTile(
                  title: Text(AppLocalizations.of(context).dark_theme),
                  onTap: () {
                    Provider.of<AppState>(context, listen: false)
                        .changeTheme(isDark: true);
                  },
                  selected: Provider.of<AppState>(context).isDark,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
