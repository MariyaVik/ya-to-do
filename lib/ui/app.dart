import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ya_to_do/ui/navigation/main_navigation.dart';

import '../mobx/state.dart';
import '../services/client_api.dart';
import 'theme/theme_light.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AppState(ClientAPI.instance)),
      ],
      child: Observer(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Provider.of<AppState>(context).currentLocale,
          title: 'To-do list',
          theme: themeLight,
          initialRoute: AppNavigation.initialRoute,
          onGenerateRoute: AppNavigation.onGenerateRoute,
        );
      }),
    );
  }
}
