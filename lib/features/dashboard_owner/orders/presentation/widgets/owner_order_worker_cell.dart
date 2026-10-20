import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OwnerOrderWorkerCell extends StatelessWidget {
  const OwnerOrderWorkerCell({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final workerId = order.workerId;
    if (workerId == null) {
      return const AppText.body('لم يتم التعيين');
    }

    final workerName = order.workerName?.trim();
    return SizedBox(
      width: 150,
      child: AppText.body(
        workerName == null || workerName.isEmpty
            ? 'اسم العامل غير متاح'
            : workerName,
        maxLines: 1,
      ),
    );
  }
}
