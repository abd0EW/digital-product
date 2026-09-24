import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OwnerSettingSwitchTile extends StatelessWidget {
  const OwnerSettingSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: AppText.body(
              title,
              textAlign: TextAlign.right,
              color: AppColors.headingText,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.success,
            inactiveThumbColor: AppColors.cardBackground,
            inactiveTrackColor: AppColors.cardBorder,
          ),
        ],
      ),
    );
  }
}
