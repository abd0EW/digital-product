import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({required this.type, super.key});

  final NotificationKind type;

  IconData get _icon {
    switch (type) {
      case NotificationKind.orderCreated:
        return Icons.sync_rounded;
      case NotificationKind.orderCompleted:
        return Icons.check_circle_outline_rounded;
      case NotificationKind.general:
        return Icons.notifications_none_rounded;
      case NotificationKind.unknown:
        return Icons.waving_hand_outlined;
    }
  }

  Color get _color {
    switch (type) {
      case NotificationKind.orderCreated:
        return AppColors.tealPrimary;
      case NotificationKind.orderCompleted:
        return AppColors.success;
      case NotificationKind.general:
        return AppColors.navyPrimary;
      case NotificationKind.unknown:
        return AppColors.bodyText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_icon, color: _color, size: 22),
    );
  }
}
