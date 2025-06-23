import 'package:flutter/material.dart';

import 'color_palette.dart';

class AppTheme {
  // copy with current text theme
  static TextTheme get textTheme => ThemeData.light().textTheme.copyWith(
        headlineLarge: kTextStyle(24),
        bodyMedium: kTextStyle(15),
      );

  TextFormField get textFormField => TextFormField(
        decoration: InputDecoration(
          hintText: "Add a task",
          // blue border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorPalette.primaryColor,
              style: BorderStyle.none,
            ),
          ),
        ),
      );

  static TextStyle kTextStyle(double fontSize) {
    return TextStyle(
      color: ColorPalette.textColor,
      fontSize: fontSize,
    );
  }

  static ThemeData get lightTheme => ThemeData(
        textTheme: textTheme,
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.primaryColor),
        useMaterial3: true,
      );
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: ColorPalette.primaryColor, brightness: Brightness.dark),
        useMaterial3: true,
      );
}
