// import 'package:flutter/material.dart';

// import '../../ui/info_screen/task_page.dart';
// import '../../ui/home_screen.dart/home_page.dart';
// import '../../ui/settings_screen/settings_page.dart';
// import 'route_name.dart';

// class AppNavigation {
//   static const initialRoute = AppNavRouteName.home;

//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppNavRouteName.home:
//         return MaterialPageRoute(builder: (context) => const HomePage());
//       case AppNavRouteName.addTask:
//         final arg = settings.arguments as String?;
//         return MaterialPageRoute(builder: (context) => TaskPage(id: arg));
//       case AppNavRouteName.settings:
//         return MaterialPageRoute(builder: (context) => const SettingsPage());

//       default:
//         return MaterialPageRoute(
//             builder: (context) => const Scaffold(
//                 body: Center(child: Text('Navigation error!!!'))));
//     }
//   }
// }
