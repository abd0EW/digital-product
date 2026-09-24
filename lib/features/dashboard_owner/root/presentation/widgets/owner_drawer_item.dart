import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OwnerDrawerItem extends StatelessWidget {
  const OwnerDrawerItem({
    required this.title,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected
        ? AppColors.secondaryIcon
        : AppColors.bodyText;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.small),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.small),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Icon(icon, color: foregroundColor, size: 22),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppText.switches(
                    title,
                    color: isSelected
                        ? AppColors.appBackground
                        : Colors.white.withOpacity(0.50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
