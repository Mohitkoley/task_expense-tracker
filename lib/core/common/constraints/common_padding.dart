import 'package:flutter/material.dart';

class CommonPadding {
  static double verticalCommonPadding = 20.0;
  static double horizontalCommonPadding = 20.0;

  static EdgeInsetsGeometry get kHorizontalPadding => EdgeInsets.symmetric(
        horizontal: horizontalCommonPadding,
      );

  static EdgeInsetsGeometry get kVerticalPadding => EdgeInsets.symmetric(
        vertical: verticalCommonPadding,
      );

  static EdgeInsetsGeometry get kCommonPadding => EdgeInsets.symmetric(
        vertical: verticalCommonPadding,
        horizontal: horizontalCommonPadding,
      );

  static EdgeInsetsGeometry get commonTextFieldPadding =>
      const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 20,
      );

  static EdgeInsetsGeometry copyWith(
    EdgeInsetsGeometry padding, {
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return EdgeInsets.only(
      top: top ?? padding.vertical,
      bottom: bottom ?? padding.vertical,
      left: left ?? padding.horizontal,
      right: right ?? padding.horizontal,
    );
  }
}
