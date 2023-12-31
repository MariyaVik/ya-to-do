import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../common/navigation/route_information_parser.dart';
import '../common/navigation/router_delegate.dart';
import '../data/config_repository.dart';
import '../mobx/state.dart';
import '../services/remote/client_api.dart';
import '../services/local/isar_service.dart';

class App extends StatelessWidget {
  App({super.key});
  // final MyRouterDelegate _routerDelegate = MyRouterDelegate();
  final _routeInformationParser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppState(
            ClientAPI.instance,
            IsarService.instance,
            ConfigRepository(FirebaseRemoteConfig.instance),
          ),
        ),
        ChangeNotifierProvider(create: (context) => MyRouterDelegate()),
        // StreamProvider<RemoteConfigUpdate>(
        //   create: (context) =>
        //       ConfigRepository(FirebaseRemoteConfig.instance).stream(),
        //   initialData: RemoteConfigUpdate({}),
        // )
      ],
      child: Observer(builder: (context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Provider.of<AppState>(context).currentLocale,
          title: 'To-do list',
          theme: Provider.of<AppState>(context).currentTheme,
          routerDelegate: Provider.of<MyRouterDelegate>(context, listen: false),
          routeInformationParser: _routeInformationParser,
        );
      }),
    );
  }
}
