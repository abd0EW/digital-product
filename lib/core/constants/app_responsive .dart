import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static double scaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width / 400;
    }
    if (width < 900) {
      return width / 700;
    }
    return width / 1000;
  }

  static double reponsiveFontSize(
    BuildContext context, {
    required double fontSize,
  }) {
    final fontSizeReponsive = fontSize * scaleFactor(context);
    final lower = fontSize * 0.8;
    final upper = fontSize * 1.2;
    return fontSizeReponsive.clamp(lower, upper);
  }
}
