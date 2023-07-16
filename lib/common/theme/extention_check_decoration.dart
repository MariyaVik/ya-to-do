import 'package:flutter/material.dart';
import 'package:ya_to_do/common/theme/colors_ligth.dart';

@immutable
class ExtentionCheckDecoration
    extends ThemeExtension<ExtentionCheckDecoration> {
  const ExtentionCheckDecoration({
    required this.done,
    required this.important,
    required this.usual,
  });

  final BoxDecoration? done;
  final BoxDecoration? important;
  final BoxDecoration? usual;

  @override
  ThemeExtension<ExtentionCheckDecoration> copyWith({
    BoxDecoration? done,
    BoxDecoration? important,
    BoxDecoration? usual,
  }) {
    return ExtentionCheckDecoration(
      done: done ?? this.done,
      important: important ?? this.important,
      usual: usual ?? this.usual,
    );
  }

  @override
  ThemeExtension<ExtentionCheckDecoration> lerp(
      ThemeExtension<ExtentionCheckDecoration>? other, double t) {
    if (other is! ExtentionCheckDecoration) {
      return this;
    }
    return ExtentionCheckDecoration(
      done: BoxDecoration.lerp(done, other.done, t),
      important: BoxDecoration.lerp(important, other.important, t),
      usual: BoxDecoration.lerp(usual, other.usual, t),
    );
  }

  @override
  String toString() {
    return 'CheckDecorations(done: $done, important: $important, usual: $usual)';
  }

  static final light = ExtentionCheckDecoration(
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
