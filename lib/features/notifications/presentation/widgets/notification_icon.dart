import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/notifications/presentation/models/notification_ui_model.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({required this.type, super.key});

  final NotificationUiType type;

  IconData get _icon {
    switch (type) {
      case NotificationUiType.inProgress:
        return Icons.sync_rounded;
      case NotificationUiType.payment:
        return Icons.credit_card_rounded;
      case NotificationUiType.completed:
        return Icons.check_circle_outline_rounded;
      case NotificationUiType.welcome:
        return Icons.waving_hand_outlined;
    }
  }

  Color get _color {
    switch (type) {
      case NotificationUiType.inProgress:
        return AppColors.tealPrimary;
      case NotificationUiType.payment:
        return AppColors.warning;
      case NotificationUiType.completed:
        return AppColors.success;
      case NotificationUiType.welcome:
        return AppColors.navyPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_icon, color: _color, size: 22),
    );
  }
}
