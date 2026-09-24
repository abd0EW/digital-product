import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/data/models/owner_order_model.dart';
import 'package:flutter/material.dart';

class OwnerOrderTableRow extends StatelessWidget {
  const OwnerOrderTableRow({
    super.key,
    required this.order,
    this.onAssignWorker,
  });

  final OwnerOrderModel order;
  final ValueChanged<OwnerOrderModel>? onAssignWorker;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (order.status.trim()) {
      'جديد' => AppColors.tealPrimary,
      'مكتمل' => AppColors.success,
      _ => AppColors.warning,
    };

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: AppText.caption(
              order.customerName,
              textAlign: TextAlign.right,
              color: AppColors.headingText,
            ),
          ),
          Expanded(
            flex: 2,
            child: AppText.caption(
              order.serviceName,
              textAlign: TextAlign.right,
              color: AppColors.headingText,
            ),
          ),
          Expanded(
            child: AppText.caption(
              order.amount,
              textAlign: TextAlign.center,
              color: AppColors.headingText,
            ),
          ),

          Expanded(
            child: Center(
              child: FittedBox(
                alignment: AlignmentGeometry.center,

                child: AppText.caption(order.status, color: statusColor),
              ),
            ),
          ),
          if (onAssignWorker != null)
            Expanded(
              child: TextButton(
                onPressed: () => onAssignWorker!(order),
                child: const AppText.body(
                  'تعيين منفذ',
                  color: AppColors.tealPrimary,
                  maxLines: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
