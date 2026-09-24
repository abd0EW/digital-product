import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/models/notification_ui_model.dart';
import 'package:flutter/material.dart';

import 'notification_icon.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification, super.key});

  final NotificationUiModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: notification.isRead
              ? AppColors.cardBorder
              : AppColors.tealPrimary,
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationIcon(type: notification.type),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.title(notification.title, maxLines: 2),
                const SizedBox(height: 4),
                AppText.body(notification.description, maxLines: 3),
                const SizedBox(height: 6),
                AppText.caption(notification.time),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 8,
            height: 8,
            child: notification.isRead
                ? null
                : DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.tealPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
