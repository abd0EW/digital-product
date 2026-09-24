import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static double scaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 700) {
      return width / 500;
    }
    if (width < 1000) {
      return width / 800;
    }
    return width / 1200;
  }

  static double reponsiveFontSize(
    BuildContext context, {
    required double fontSize,
  }) {
    final fontSizeReponsive = fontSize * scaleFactor(context);
    final lower = fontSize * 0.9;
    final upper = fontSize * 1.3;
    return fontSizeReponsive.clamp(lower, upper);
  }
}
