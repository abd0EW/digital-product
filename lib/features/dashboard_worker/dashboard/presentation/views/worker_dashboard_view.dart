import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_header_view.dart';
import 'package:digital_product/features/dashboard_worker/dashboard/presentation/widgets/worker_dashboard_summary_sliver.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_data.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/widgets/worker_order_card.dart';
import 'package:flutter/material.dart';

class WorkerDashboardView extends StatelessWidget {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final assignedOrders = assignedWorkerOrders
        .where((order) => order.status != WorkerOrderStatus.completed)
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: AppHeaderView(textHedader: 'الرئيسية'),
                ),
              ),
              WorkerDashboardSummarySliver(orders: assignedWorkerOrders),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.xl,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const AppHeaderView(textHedader: 'الطلبات المسندة إليك'),
                    const SizedBox(height: AppSpacing.sm),
                    ...assignedOrders.map(
                      (order) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: WorkerOrderCard(order: order),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
