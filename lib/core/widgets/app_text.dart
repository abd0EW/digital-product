import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.color,
    this.usePrimaryColor = true,
    super.key,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final Color? color;
  final bool usePrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color:
            color ??
            (usePrimaryColor ? AppColors.navyPrimary : AppColors.tealPrimary),
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}
