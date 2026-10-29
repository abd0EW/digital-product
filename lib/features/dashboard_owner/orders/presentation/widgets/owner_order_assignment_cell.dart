import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/worker_assignment_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrderAssignmentCell extends StatelessWidget {
  const OwnerOrderAssignmentCell({required this.order, super.key});

  final OrderModel order;

  bool get _isInProgress => order.status.trim().toLowerCase() == 'in_progress';

  Future<void> _showAssignmentSheet(BuildContext context) async {
    final orderId = order.id;
    if (orderId == null) return;

    final worker = await WorkerAssignmentBottomSheet.show(
      context,
      orderId: orderId,
    );

    if (worker == null || !context.mounted) return;

    await context.read<GetOrderCubit>().refreshOwnerOrders();
    if (!context.mounted) return;

    AppSnackbar.success(
      context,
      message: 'تم تعيين ${worker.fullName} للطلب بنجاح',
    );

    if (context.read<GetOrderCubit>().state is GetOrderFailure) {
      AppSnackbar.error(
        context,
        message: 'تم التعيين، لكن تعذر تحديث قائمة الطلبات.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInProgress) {
      return const AppText.body('—');
    }

    if (order.workerId != null || order.id == null) {
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
