import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle appTitle = TextStyle(
    color: AppColors.headingText,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle heading = TextStyle(
    color: AppColors.headingText,
    fontSize: 28,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle subtitle = TextStyle(
    color: AppColors.bodyText,
    fontSize: 15,
    height: 1.6,
  );

  static const TextStyle label = TextStyle(
    color: AppColors.headingText,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.bodyText,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
}
