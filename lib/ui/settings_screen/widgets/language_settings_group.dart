import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../mobx/state.dart';
import '../../common/my_card.dart';

class LanguageSettingGroup extends StatelessWidget {
  const LanguageSettingGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            AppLocalizations.of(context).language_setting,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        MyCard(
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
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: AppLocalizations.supportedLocales.length),
        ),
      ],
    );
  }
}
