import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class NotificationsErrorView extends StatelessWidget {
  const NotificationsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 42,
              color: AppColors.bodyText,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppText.body(
              message,
              color: AppColors.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
