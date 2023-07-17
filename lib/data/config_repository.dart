import 'dart:async';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepository {
  final FirebaseRemoteConfig remoteConfig;

  ConfigRepository(this.remoteConfig);

  String get importanceColor {
    log('ПОЛУЧАЕМ ИЗ РЕПЫ');

    return remoteConfig.getString(ConfigFields.importanceColor);
  }

  Future<void> init() async {
    await remoteConfig.ensureInitialized();
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    remoteConfig.setDefaults({
      ConfigFields.importanceColor: '',
    });
    log('ИНИТ КОНФИГ');
    await remoteConfig.fetchAndActivate();
  }

  // Stream<RemoteConfigUpdate> stream() {
  //   return remoteConfig.onConfigUpdated;
  //   // .listen((event) async {
  //   //   log('НОВОЕ ЗНАЧЕНИЕ ${event.updatedKeys}');

  //   //   await _remoteConfig.activate();
  //   // });
  // }

  // Future<void> listen() async {
  //   remoteConfig.onConfigUpdated.listen((event) async {
  //     log('НОВОЕ ЗНАЧЕНИЕ ${event.updatedKeys}');

  //     await remoteConfig.activate();
  //   });
  // }
}

abstract class ConfigFields {
  static const importanceColor = 'importance_color';
}
