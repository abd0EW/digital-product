import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/order_display_formatter.dart';
import 'package:digital_product/core/widgets/app_fail_state_silver.dart';
import 'package:digital_product/core/widgets/app_state_loading_silver.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_assignment_cell.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_worker_cell.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrdersTable extends StatelessWidget {
  const OwnerOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderCubit, GetOrderState>(
      builder: (context, state) {
        if (state is GetOrderInitial || state is GetOrderLoading) {
          return const AppStateLoadingSilver();
        }

        if (state is GetOrderFailure) {
          return AppFailStateSilver(failureMessage: state.message);
        }

        if (state is GetOrderEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: AppText.body('لا توجد طلبات ضمن هذا التصنيف')),
          );
        }

        if (state is GetOrderSuccess) {
          return _buildTable(state.orders);
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: AppText.body('لا توجد طلبات')),
        );
      },
    );
  }

  Widget _buildTable(List<OrderModel> orders) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppText.body('عدد الطلبات: ${orders.length}'),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        AppColors.appBackground,
                      ),
                      columns: const [
                        DataColumn(label: Text('رقم الطلب')),
                        DataColumn(label: Text('الخدمة')),
                        DataColumn(label: Text('السعر الكلي')),
                        DataColumn(label: Text('حالة الخدمة')),
                        DataColumn(label: Text('المسؤول عن التنفيذ')),
                        DataColumn(label: Text('الإجراء')),
                      ],
                      rows: orders.map(_buildRow).toList(growable: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildRow(OrderModel order) {
    final orderReference =
        order.orderNumber?.toString() ?? order.id ?? 'غير متاح';
    final amount = OrderDisplayFormatter.price(order.totalAmount);
    final currency = order.service?.currency;

    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 100,
            child: Text(orderReference, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 125,
            child: Text(
              order.service?.nameAr ?? 'غير متاحة',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Text(currency == null ? amount : '$amount $currency')),
        DataCell(OrderStatusBadge(status: order.status)),
        DataCell(OwnerOrderWorkerCell(order: order)),
        DataCell(OwnerOrderAssignmentCell(order: order)),
      ],
    );
  }
}
