import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TeamHeaderSliver extends StatelessWidget {
  const TeamHeaderSliver({
    required this.isAddingAssistant,
    required this.onAddAssistant,
    super.key,
  });

  final bool isAddingAssistant;
  final VoidCallback onAddAssistant;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            const Expanded(child: AppText.title('الفريق')),
            FittedBox(
              child: AppButton(
                title: isAddingAssistant ? 'إخفاء' : '+ إضافة مساعد',
                onPressed: onAddAssistant,
                backgroundColor: AppColors.navyPrimary,
                foregroundColor: AppColors.whiteText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
