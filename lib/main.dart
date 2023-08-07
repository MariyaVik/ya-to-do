import 'package:flutter/material.dart';

import 'common/di.dart';
import 'ui/app.dart';

void main() async {
  await ServiceLocator.init();
  runApp(App());
}
