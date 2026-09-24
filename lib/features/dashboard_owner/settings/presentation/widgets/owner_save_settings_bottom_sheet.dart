import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OwnerSaveSettingsBottomSheet extends StatelessWidget {
  const OwnerSaveSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.large),
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.title('حفظ الإعدادات', textAlign: TextAlign.right),
              const SizedBox(height: AppSpacing.sm),
              AppText.body(
                'هل تريد حفظ التغييرات الحالية؟',
                textAlign: TextAlign.right,
                color: AppColors.bodyText,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'حفظ',
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: AppColors.primaryButtonBackground,
                      foregroundColor: AppColors.whiteText,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppButton(
                      title: 'إلغاء',
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: AppColors.cardBackground,
                      foregroundColor: AppColors.primaryButtonBackground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
