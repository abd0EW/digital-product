import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_owner/orders/data/models/owner_order_model.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_table_header.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_table_row.dart';
import 'package:flutter/material.dart';

class OwnerOrdersTable extends StatelessWidget {
  const OwnerOrdersTable({
    super.key,
    required this.orders,
    this.onAssignWorker,
  });

  final List<OwnerOrderModel> orders;
  final ValueChanged<OwnerOrderModel>? onAssignWorker;

  bool get showAssignmentAction => onAssignWorker != null;
  @override
  Widget build(BuildContext context) {
    final dividerColor = AppColors.headingText.withValues(alpha: 0.08);

    return SingleChildScrollView(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(color: dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),

              child: OwnerOrderTableHeader(
                showAssignmentAction: showAssignmentAction,
              ),
            ),

            /// Rows
            ...List.generate(orders.length, (index) {
              final order = orders[index];

              return OwnerOrderTableRow(
                order: order,
                onAssignWorker: onAssignWorker,
              );
            }),
          ],
        ),
      ),
    );
  }
}
