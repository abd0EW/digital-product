import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/demo_worker_option_tile.dart';
import 'package:flutter/material.dart';

class WorkerAssignmentBottomSheet extends StatelessWidget {
  const WorkerAssignmentBottomSheet({super.key});

  static const DemoWorker _demoWorker = DemoWorker(
    id: 'demo-worker-001',
    name: 'Ahmed Mohamed',
  );

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<DemoWorker> onWorkerSelected,
  }) async {
    final worker = await showModalBottomSheet<DemoWorker>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WorkerAssignmentBottomSheet(),
    );

    if (worker != null && context.mounted) onWorkerSelected(worker);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.lg,
        ),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.medium),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const AppText.title('تعيين عامل'),
            const SizedBox(height: AppSpacing.xs),
            const AppText.body('اختيار تجريبي فقط، لن يتم حفظه في الطلب.'),
            const SizedBox(height: AppSpacing.md),
            DemoWorkerOptionTile(
              worker: _demoWorker,
              onTap: () => Navigator.of(context).pop(_demoWorker),
            ),
          ],
        ),
      ),
    );
  }
}
