import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class DemoWorker {
  const DemoWorker({required this.id, required this.name});

  final String id;
  final String name;
}

class DemoWorkerOptionTile extends StatelessWidget {
  const DemoWorkerOptionTile({
    required this.worker,
    required this.onTap,
    super.key,
  });

  final DemoWorker worker;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.successBackground,
                child: Icon(Icons.person, color: AppColors.tealPrimary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.title(worker.name),
                    const SizedBox(height: 4),
                    AppText.caption('معرّف تجريبي: ${worker.id}'),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
