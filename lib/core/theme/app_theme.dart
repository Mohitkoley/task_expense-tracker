import 'package:flutter/material.dart';

import 'color_palette.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
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
