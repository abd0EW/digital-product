import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/utils/order_display_formatter.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.trim().toLowerCase();
    final backgroundColor = switch (normalizedStatus) {
      'completed' => AppColors.successBackground,
      'pending' => AppColors.warningBackground,
      _ => AppColors.cardBorder,
    };
    final foregroundColor = switch (normalizedStatus) {
      'completed' => AppColors.success,
      'pending' => AppColors.warning,
      _ => AppColors.headingText,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs / 2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: AppText.caption(
        OrderDisplayFormatter.statusLabel(status),
        color: foregroundColor,
        maxLines: 1,
      ),
    );
  }
}
