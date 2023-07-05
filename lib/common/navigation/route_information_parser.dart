import 'package:flutter/material.dart';

import 'navigation_state.dart';
import 'route_name.dart';

/// URI <> NavigationState
class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unknown();
    }

    final uri = Uri.parse(location);

    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2) {
      final itemId = uri.pathSegments[1];

// !!! ПРОВЕРИТЬ НА НАЛИЧИЕ ЗАДАЧИ !!!
      if (uri.pathSegments[0] == AppNavRouteName.task) {
        if (uri.pathSegments[1] == AppNavRouteName.newTask) {
          return NavigationState.newTask();
        }
        return NavigationState.task(itemId);
      }

      return NavigationState.unknown();
    }

    if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];
      if (path == AppNavRouteName.settings) {
        return NavigationState.settings();
      }

      return NavigationState.root();
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isSettings) {
      return const RouteInformation(location: '/${AppNavRouteName.settings}');
    }

    if (configuration.isAddScreen) {
      return const RouteInformation(
          location: '/${AppNavRouteName.task}/${AppNavRouteName.newTask}');
    }

    if (configuration.isEditScreen) {
      return RouteInformation(
          location: '/${AppNavRouteName.task}/${configuration.selectedItemId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
