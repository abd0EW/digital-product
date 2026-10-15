import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class NotificationsEmptyView extends StatelessWidget {
  const NotificationsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 48,
              color: AppColors.bodyText,
            ),
            SizedBox(height: AppSpacing.sm),
            AppText.body(
              'ما عندك إشعارات جديدة حاليًا.',
              color: AppColors.bodyText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
