import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ya_to_do/ui/navigation/main_navigation.dart';

import '../mobx/state.dart';
import 'theme/theme_light.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AppState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('ru'), Locale('en')],
        title: 'Список дел',
        theme: themeLight,
        initialRoute: AppNavigation.initialRoute,
        onGenerateRoute: AppNavigation.onGenerateRoute,
      ),
    );
  }
}
