import 'package:flutter/material.dart';

class CurrentScreen extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  static const double _short = 600;
  static const double _long = 800;

  const CurrentScreen({
    required this.mobile,
    required this.tablet,
    Key? key,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < _short &&
          MediaQuery.of(context).size.height < _long ||
      MediaQuery.of(context).size.height < _short &&
          MediaQuery.of(context).size.width < _long;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= _short &&
          MediaQuery.of(context).size.height >= _long ||
      MediaQuery.of(context).size.height >= _short &&
          MediaQuery.of(context).size.width >= _long;

  @override
  Widget build(BuildContext context) {
    if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
