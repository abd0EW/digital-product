import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_header_view.dart';
import 'package:digital_product/core/widgets/app_order_filter_chips.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_data.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/widgets/worker_order_card.dart';
import 'package:flutter/material.dart';

class WorkerOrdersView extends StatefulWidget {
  const WorkerOrdersView({super.key});

  @override
  State<WorkerOrdersView> createState() => _WorkerOrdersViewState();
}

class _WorkerOrdersViewState extends State<WorkerOrdersView> {
  String selectedFilter = 'جديدة';

  List<WorkerOrderModel> get filteredOrders {
    final status = switch (selectedFilter) {
      'جديدة' => WorkerOrderStatus.newOrder,
      'قيد التنفيذ' => WorkerOrderStatus.inProgress,
      'مكتملة' => WorkerOrderStatus.completed,
      _ => WorkerOrderStatus.newOrder,
    };
    return assignedWorkerOrders
        .where((order) => order.status == status)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: AppHeaderView(textHedader: 'الطلبات'),
                ),
              ),
              AppOrderFilterChips(
                selectedFilter: selectedFilter,
                filters: const ['جديدة', 'قيد التنفيذ', 'مكتملة'],
                onFilterSelected: (filter) =>
                    setState(() => selectedFilter = filter),
              ),
              if (filteredOrders.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: AppText.body('لا توجد طلبات')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  sliver: SliverList.separated(
                    itemCount: filteredOrders.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) =>
                        WorkerOrderCard(order: filteredOrders[index]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
