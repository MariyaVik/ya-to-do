import 'package:flutter/material.dart';

import 'colors_ligth.dart';
import 'extention_check_decoration.dart';

ThemeData _themeLight = ThemeData.light();

ThemeData themeLight = _themeLight.copyWith(
    extensions: [ExtentionCheckDecoration.light],
    colorScheme: _schemeLight(_themeLight.colorScheme),
    textButtonTheme: TextButtonThemeData(style: _textButtonLight),
    textTheme: _textLight(_themeLight.textTheme),
    scaffoldBackgroundColor: ColorsLight.backPrimary,
    switchTheme: _switchLight(_themeLight.switchTheme),
    inputDecorationTheme: _inputDecorLight(_themeLight.inputDecorationTheme),
    dropdownMenuTheme: _dropDownLight(_themeLight.dropdownMenuTheme));

ColorScheme _schemeLight(ColorScheme base) {
  return base.copyWith(
    background: ColorsLight.backPrimary,
    surface: ColorsLight.backSecondary,
    error: ColorsLight.red,
    primary: ColorsLight.blue,
    outline: ColorsLight.green,
    tertiary: ColorsLight.labelTertiary,
    shadow: ColorsLight.grey,
  );
}

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
      titleLarge: base.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 32,
        height: 1.19,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        height: 1.6,
        letterSpacing: 0.5,
      ),
      labelLarge: base.labelLarge!.copyWith(
        // button
        fontSize: 14,
        height: 1.7,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.16,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: 16,
        height: 1.25,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontSize: 14,
        height: 1.43,
      ));
}

ButtonStyle _textButtonLight = TextButton.styleFrom(
  foregroundColor: ColorsLight.blue,
  disabledForegroundColor: ColorsLight.labelDisable,
);

DropdownMenuThemeData _dropDownLight(DropdownMenuThemeData base) {
  return base.copyWith(
    menuStyle: MenuStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(ColorsLight.backElevated),
    ),
  );
}

SwitchThemeData _switchLight(SwitchThemeData base) {
  return base.copyWith(
    trackColor: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
        states.contains(MaterialState.selected)
            ? ColorsLight.blue.withOpacity(0.3)
            : ColorsLight.supportOverlay),
  );
}

InputDecorationTheme _inputDecorLight(InputDecorationTheme base) {
  return base.copyWith(
      // errorStyle: TextStyle(fontSize: 0, height: 0),
      isDense: true,
      hintStyle: const TextStyle(
          fontSize: 16, height: 1.25, color: ColorsLight.labelTertiary),
      filled: true,
      fillColor: ColorsLight.backSecondary,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)));
}
