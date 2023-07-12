import 'package:flutter/material.dart';

import 'colors_dark.dart';
import 'extention_check_decoration.dart';

ThemeData _themeDark = ThemeData.dark();

ThemeData themeDark = _themeDark.copyWith(
  extensions: [ExtentionCheckDecoration.dark],
  colorScheme: _schemeLight(_themeDark.colorScheme),
  textButtonTheme: TextButtonThemeData(style: _textButtonLight),
  textTheme: _textLight(_themeDark.textTheme),
  scaffoldBackgroundColor: ColorsDark.backPrimary,
  switchTheme: _switchLight(_themeDark.switchTheme),
  inputDecorationTheme: _inputDecorLight(_themeDark.inputDecorationTheme),
  dropdownMenuTheme: _dropDownLight(_themeDark.dropdownMenuTheme),
  floatingActionButtonTheme: _floatButton(_themeDark.floatingActionButtonTheme),
);

ColorScheme _schemeLight(ColorScheme base) {
  return base.copyWith(
    background: ColorsDark.backPrimary,
    surface: ColorsDark.backSecondary,
    error: ColorsDark.red,
    primary: ColorsDark.blue,
    secondary: ColorsDark.blue,
    outline: ColorsDark.green,
    tertiary: ColorsDark.labelTertiary,
    shadow: ColorsDark.grey,
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
  foregroundColor: ColorsDark.blue,
  disabledForegroundColor: ColorsDark.labelDisable,
);

DropdownMenuThemeData _dropDownLight(DropdownMenuThemeData base) {
  return base.copyWith(
    menuStyle: MenuStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(ColorsDark.backElevated),
    ),
  );
}

SwitchThemeData _switchLight(SwitchThemeData base) {
  return base.copyWith(
    trackColor: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
        states.contains(MaterialState.selected)
            ? ColorsDark.blue.withOpacity(0.3)
            : ColorsDark.supportOverlay),
  );
}

InputDecorationTheme _inputDecorLight(InputDecorationTheme base) {
  return base.copyWith(
      // errorStyle: TextStyle(fontSize: 0, height: 0),
      isDense: true,
      hintStyle: const TextStyle(
          fontSize: 16, height: 1.25, color: ColorsDark.labelTertiary),
      filled: true,
      fillColor: ColorsDark.backSecondary,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)));
}

FloatingActionButtonThemeData _floatButton(FloatingActionButtonThemeData base) {
  return base.copyWith(foregroundColor: ColorsDark.white);
}
