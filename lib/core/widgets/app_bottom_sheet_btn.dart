import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppBottomSheetBtn extends StatelessWidget {
  const AppBottomSheetBtn({
    super.key,
    required this.title,
    this.color,
    this.onPressed,
    this.disabled = false,
  });

  final String title;
  final Color? color;
  final VoidCallback? onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.appBackground,
          border: Border(
            top: BorderSide(
              color: AppColors.headingText.withValues(alpha: 0.08),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: AppButton(
          width: double.infinity,
          title: title,
          onPressed: disabled ? null : (onPressed ?? () {}),
          backgroundColor: color ?? AppColors.secondaryButtonBackground,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
