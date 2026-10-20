import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/worker_assignment_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OwnerOrderAssignmentCell extends StatelessWidget {
  const OwnerOrderAssignmentCell({required this.order, super.key});

  final OrderModel order;

  bool get _isInProgress => order.status.trim().toLowerCase() == 'in_progress';

  Future<void> _showAssignmentSheet(BuildContext context) {
    return WorkerAssignmentBottomSheet.show(
      context,
      onWorkerSelected: (worker) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم اختيار ${worker.name} للتجربة فقط؛ لم يتم حفظ التعيين.',
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInProgress) {
      return const AppText.body('—');
    }

    if (order.workerId != null) {
      return const AppText.body('—');
    }

    return TextButton.icon(
      onPressed: () => _showAssignmentSheet(context),
      icon: const Icon(Icons.person_add_alt_1, size: 18),
      label: const Text('تعيين عامل'),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.tealPrimary,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      ),
    );
  }
}
