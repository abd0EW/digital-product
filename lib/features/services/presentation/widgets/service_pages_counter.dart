import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/services/presentation/widgets/service_counter_button.dart';

import 'package:flutter/material.dart';

class ServicePagesCounter extends StatelessWidget {
  const ServicePagesCounter({
    super.key,
    required this.pagesCount,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int pagesCount;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText.title('عدد الصفحات', color: AppColors.headingText),

        const SizedBox(height: 8),

        Row(
          children: [
            ServiceCounterButton(
              icon: Icons.add,
              isPrimary: true,
              onTap: onIncrement,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.inputBorder),
                ),
                alignment: Alignment.center,
                child: AppText.title(
                  pagesCount.toString(),
                  color: AppColors.headingText,
                ),
              ),
            ),

            const SizedBox(width: 12),

            ServiceCounterButton(icon: Icons.remove, onTap: onDecrement),
          ],
        ),
      ],
    );
  }
}
