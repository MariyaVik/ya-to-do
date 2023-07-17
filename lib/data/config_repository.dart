import 'dart:async';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepository(this._remoteConfig);

  String get importanceColor {
    log('ПОЛУЧАЕМ ИЗ РЕПЫ');

    return _remoteConfig.getString(ConfigFields.importanceColor);
  }

  Future<void> init() async {
    _remoteConfig.setDefaults({
      ConfigFields.importanceColor: '',
    });
    log('ИНИТ КОНФИГ');
    await _remoteConfig.fetchAndActivate();
  }

  Stream<RemoteConfigUpdate> stream() {
    return _remoteConfig.onConfigUpdated;
    // .listen((event) async {
    //   log('НОВОЕ ЗНАЧЕНИЕ ${event.updatedKeys}');

    //   await _remoteConfig.activate();
    // });
  }

  Future<void> listen() async {
    _remoteConfig.onConfigUpdated.listen((event) async {
      log('НОВОЕ ЗНАЧЕНИЕ ${event.updatedKeys}');

      await _remoteConfig.activate();
    });
  }
}

abstract class ConfigFields {
  static const importanceColor = 'importance_color';
}
