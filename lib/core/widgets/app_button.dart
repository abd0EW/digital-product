import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isLoading = false,
    this.width,
    this.height = 54,
    this.borderColor,
    this.icon,
    super.key,
  });

  final String title;
  final VoidCallback? onPressed;

  final bool isLoading;

  final double? width;
  final double height;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(strokeWidth: 2, color: foregroundColor)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: AppText.title(title, color: foregroundColor)),
                ],
              ),
      ),
    );
  }
}
