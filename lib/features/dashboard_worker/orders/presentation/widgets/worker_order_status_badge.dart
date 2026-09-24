import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:flutter/material.dart';

class WorkerOrderStatusBadge extends StatelessWidget {
  const WorkerOrderStatusBadge({required this.status, super.key});

  final WorkerOrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppText.caption(status.label, color: status.color),
    );
  }
}
