import 'package:flutter/material.dart';
import 'package:ya_to_do/ui/theme/colors_ligth.dart';

@immutable
class CheckDecorations extends ThemeExtension<CheckDecorations> {
  const CheckDecorations({
    required this.done,
    required this.important,
    required this.usual,
  });

  final BoxDecoration? done;
  final BoxDecoration? important;
  final BoxDecoration? usual;

  @override
  ThemeExtension<CheckDecorations> copyWith({
    BoxDecoration? done,
    BoxDecoration? important,
    BoxDecoration? usual,
  }) {
    return CheckDecorations(
      done: done ?? this.done,
      important: important ?? this.important,
      usual: usual ?? this.usual,
    );
  }

  @override
  ThemeExtension<CheckDecorations> lerp(
      ThemeExtension<CheckDecorations>? other, double t) {
    if (other is! CheckDecorations) {
      return this;
    }
    return CheckDecorations(
      done: BoxDecoration.lerp(done, other.done, t),
      important: BoxDecoration.lerp(important, other.important, t),
      usual: BoxDecoration.lerp(usual, other.usual, t),
    );
  }

  @override
  String toString() {
    return 'CheckDecorations(done: $done, important: $important, usual: $usual)';
  }

  static final light = CheckDecorations(
    done: BoxDecoration(
        borderRadius: BorderRadius.circular(3), color: ColorsLight.green),
    important: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: ColorsLight.red.withOpacity(0.16),
        border: Border.all(width: 2, color: ColorsLight.red)),
    usual: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.transparent,
        border: Border.all(width: 2, color: ColorsLight.supportSeparator)),
  );

  // static const dark = CheckDecorations(
  //   success: Color.fromARGB(255, 226, 234, 8),
  //   failure: Color.fromARGB(255, 205, 127, 18),
  // );
}
