import 'package:flutter/material.dart';

import '../info_screen/add_task_page.dart';
import '../home_screen.dart/home_page.dart';
import '../settings_screen/settings_page.dart';
import 'route_name.dart';

class AppNavigation {
  static const initialRoute = AppNavRouteName.home;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavRouteName.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppNavRouteName.addTask:
        final arg = settings.arguments as int?;
        return MaterialPageRoute(builder: (context) => AddTaskPage(id: arg));
      case AppNavRouteName.settings:
        return MaterialPageRoute(builder: (context) => const SettingsPage());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                body: Center(child: Text('Navigation error!!!'))));
    }
  }
}
