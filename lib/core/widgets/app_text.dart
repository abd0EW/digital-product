import 'package:flutter/material.dart';
import 'package:digital_product/core/constants/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText.title(
    this.text, {
    super.key,
    this.color = AppColors.headingText,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  }) : fontSize = 22,
       fontWeight = FontWeight.w800,
       height = 1;

  const AppText.switches(
    this.text, {
    super.key,
    this.color = AppColors.headingText,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  }) : fontSize = 18,
       fontWeight = FontWeight.w500,
       height = 1;

  const AppText.caption(
    this.text, {
    super.key,
    this.color = const Color.fromRGBO(140, 140, 140, 1),
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  }) : fontSize = 17,
       fontWeight = FontWeight.w600,
       height = 1;

  const AppText.body(
    this.text, {
    super.key,
    this.color = AppColors.bodyText,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  }) : fontSize = 13,
       fontWeight = FontWeight.w500,
       height = 1.4;

  final String text;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow : null,
      style: TextStyle(
        fontFamily: 'Parastoo',
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
      ),
    );
  }
}
