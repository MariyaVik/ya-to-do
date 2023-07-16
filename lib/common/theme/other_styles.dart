import 'package:flutter/material.dart';

List<BoxShadow> headerShadow(double coef) {
  return [
    BoxShadow(
        color: Colors.black.withOpacity(0.2 * coef),
        blurRadius: 10.0,
        offset: const Offset(0.0, 1)),
    BoxShadow(
        color: Colors.black.withOpacity(0.12 * coef),
        blurRadius: 5.0,
        offset: const Offset(0.0, 4)),
    BoxShadow(
        color: Colors.black.withOpacity(0.14 * coef),
        blurRadius: 4.0,
        offset: const Offset(0.0, 2)),
  ];
}

List<BoxShadow> cardShadow() {
  return [
    BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: 2.0,
        offset: const Offset(0.0, 2)),
    BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 2.0,
        offset: const Offset(0.0, 0)),
  ];
}
