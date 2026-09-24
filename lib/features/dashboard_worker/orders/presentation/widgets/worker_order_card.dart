import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_service_icon.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/views/worker_order_details_view.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/widgets/worker_order_status_badge.dart';
import 'package:flutter/material.dart';

class WorkerOrderCard extends StatelessWidget {
  const WorkerOrderCard({required this.order, super.key});

  final WorkerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => WorkerOrderDetailsView(order: order),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            AppServiceIcon(serviceName: order.serviceName),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(order.serviceName, maxLines: 1),
                  const SizedBox(height: 4),
                  AppText.body(order.customerName, maxLines: 1),
                  const SizedBox(height: AppSpacing.xs),
                  AppText.caption(order.orderNumber, color: AppColors.bodyText),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            WorkerOrderStatusBadge(status: order.status),
          ],
        ),
      ),
    );
  }
}
