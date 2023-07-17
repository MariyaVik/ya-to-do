import 'package:flutter/material.dart';
import 'package:ya_to_do/common/utils.dart';

import 'colors_dark.dart';
import 'colors_ligth.dart';

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

BoxDecoration checkDecorDark(String impColor) {
  final color = impColor == '' ? ColorsDark.red : impColor.toColor();
  return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: color.withOpacity(0.16),
      border: Border.all(width: 2, color: color));
}

BoxDecoration checkDecorLight(String impColor) {
  final color = impColor == '' ? ColorsLight.red : impColor.toColor();
  return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: color.withOpacity(0.16),
      border: Border.all(width: 2, color: color));
}
