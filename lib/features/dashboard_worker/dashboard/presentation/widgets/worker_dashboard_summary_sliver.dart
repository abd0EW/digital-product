import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:flutter/material.dart';

class WorkerDashboardSummarySliver extends StatelessWidget {
  const WorkerDashboardSummarySliver({required this.orders, super.key});

  final List<WorkerOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    final newCount = orders
        .where((order) => order.status == WorkerOrderStatus.newOrder)
        .length;
    final inProgressCount = orders
        .where((order) => order.status == WorkerOrderStatus.inProgress)
        .length;
    final completedCount = orders
        .where((order) => order.status == WorkerOrderStatus.completed)
        .length;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            _SummaryItem(
              title: 'جديدة',
              value: newCount,
              color: AppColors.tealPrimary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _SummaryItem(
              title: 'قيد التنفيذ',
              value: inProgressCount,
              color: AppColors.warning,
            ),
            const SizedBox(width: AppSpacing.sm),
            _SummaryItem(
              title: 'مكتملة',
              value: completedCount,
              color: AppColors.success,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Column(
          children: [
            AppText.title('$value', color: color),
            const SizedBox(height: 4),
            AppText.body(title, maxLines: 1, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
