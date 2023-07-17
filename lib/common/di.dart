import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../data/config_repository.dart';
import '../firebase_options.dart';
import 'logger.dart';

abstract class ServiceLocator {
  static final _locator = GetIt.instance;

  static ConfigRepository get configRepository => _locator<ConfigRepository>();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();
    // _initCrashlytics();

    // _locator.registerLazySingleton<FirebaseRemoteConfig>(
    //   () => FirebaseRemoteConfig.instance,
    // );

    // final configRepo = ConfigRepository(_locator<FirebaseRemoteConfig>());
    // await configRepo.init();
    // _locator.registerSingleton<ConfigRepository>(configRepo);
  }

  static Future<void> _initFirebase() async {
    logger.d('Firebase initialization started');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    logger.d('Firebase initialized');
  }

  // static void _initCrashlytics() {
  //   FlutterError.onError = (errorDetails) {
  //     logger.d('Caught error in FlutterError.onError');
  //     FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  //   };

  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     logger.d('Caught error in PlatformDispatcher.onError');
  //     FirebaseCrashlytics.instance.recordError(
  //       error,
  //       stack,
  //       fatal: true,
  //     );
  //     return true;
  //   };
  //   logger.d('Crashlytics initialized');
  // }

  static Future<void> dispose() async {}
}
