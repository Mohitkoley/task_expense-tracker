import 'package:flutter/material.dart';

class CommonConstraints {
  // PrefixConstraints
  static double get textFieldIconMaxHeight => 40;
  static double get textFieldIconMaxWidth => 40;
  static double get textFieldIconMinWidth => 40;
  static double get textFieldIconMinHeight => 40;
  // TextField
  static double get textFieldMaxHeight => 80;
  static double get textFieldMinHeight => 50;

  // PrefixConstraints
  static BoxConstraints get textFieldPrefixConstraints => BoxConstraints(
        maxHeight: textFieldIconMaxHeight,
        maxWidth: textFieldIconMaxWidth,
        minWidth: textFieldIconMinWidth,
        minHeight: textFieldIconMinHeight,
      );

  //suffixConstraints
  static BoxConstraints get textFieldSuffixConstraints => BoxConstraints(
        maxHeight: textFieldIconMaxHeight,
        maxWidth: textFieldIconMaxWidth,
        minWidth: textFieldIconMinWidth,
        minHeight: textFieldIconMinHeight,
      );

  static BoxConstraints get textFieldBoxConstraints => BoxConstraints(
      minHeight: textFieldMinHeight, maxHeight: textFieldMaxHeight);

  static BoxConstraints get textFieldIconBoxConstraints => BoxConstraints(
        maxHeight: textFieldIconMaxHeight,
        maxWidth: textFieldIconMaxWidth,
        minWidth: textFieldIconMinWidth,
        minHeight: textFieldIconMinHeight,
      );

  static BoxConstraints get textFieldBoxConstraintsMaxHeight =>
      BoxConstraints(maxHeight: textFieldMaxHeight);
}
