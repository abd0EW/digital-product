import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_order_card_info.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_status_badge.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, required this.onPressed, super.key});

  final OrderModel order;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.cardBackground,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: GestureDetector(
        onTap: onPressed,

        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              AppOrderCardInfo(order: order),

              const SizedBox(height: AppSpacing.sm),
              const Divider(height: 1, color: AppColors.cardBorder),
              const SizedBox(height: AppSpacing.sm),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderStatusBadge(status: order.status),
                  AppText.title(
                    '${order.price} ر.س',
                    color: AppColors.secondaryButtonBackground,
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
