import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_details_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_status_badge.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({required this.order, super.key});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText.title('معلومات الطلب'),
              OrderStatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _infoRow('اسم الطلب ', order.service?.nameAr ?? "الخدمه"),

          _infoRow('الكمية', '${order.quantity}'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: AppText.caption(label, color: Colors.black)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: AppText.caption(
              value,
              color: AppColors.headingText,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
