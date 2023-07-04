import 'package:flutter/material.dart';

import '../../ui/home_screen.dart/home_page.dart';
import '../../ui/info_screen/task_page.dart';
import '../../ui/settings_screen/settings_page.dart';
import 'navigation_state.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  NavigationState get currentConfiguration {
    return state ?? NavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          child: HomePage(),
        ),
        if (state?.isSettings == true)
          const MaterialPage(
            child: SettingsPage(),
          ),
        if (state?.isEditScreen == true)
          MaterialPage(
            child: TaskPage(
              id: state?.selectedItemId,
            ),
          ),
        if (state?.isAddScreen == true)
          const MaterialPage(
            child: TaskPage(),
          ),
        if (state?.isUnknown == true)
          const MaterialPage(
            child: Scaffold(body: Center(child: Text('Navigation error!!!'))),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void showTask([String? itemId]) {
    state = itemId == null
        ? NavigationState.newTask()
        : NavigationState.task(itemId);
    notifyListeners();
  }

  void showSettings() {
    state = NavigationState.settings();
    notifyListeners();
  }
}
