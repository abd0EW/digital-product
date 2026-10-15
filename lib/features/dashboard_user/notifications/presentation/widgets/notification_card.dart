import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/utils/notification_time_formatter.dart';
import 'package:flutter/material.dart';
import 'notification_icon.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    required this.onTap,
    this.isBusy = false,
    super.key,
  });

  final NotificationModel notification;
  final VoidCallback onTap;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(notification.id),
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: notification.isRead
                ? AppColors.bodyText
                : AppColors.tealPrimary.withValues(alpha: 0.45),
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIcon(type: notification.kind),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(notification.title, maxLines: 2),
                  const SizedBox(height: 4),
                  AppText.body(notification.body, maxLines: 3),
                  const SizedBox(height: 6),
                  AppText.caption(
                    NotificationTimeFormatter.format(
                      notification.sentAt ?? notification.createdAt,
                    ),
                    color: AppColors.headingText,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(
              width: 20,
              height: 20,
              child: isBusy
                  ? const Padding(
                      padding: EdgeInsets.all(2),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : notification.isRead
                  ? null
                  : const Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.tealPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(width: 8, height: 8),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
