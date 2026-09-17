import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.showDivider = true,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Icon(icon, color: AppColors.secondaryIcon, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: AppText.title(title)),
                const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.bodyText,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1, color: AppColors.cardBorder),
      ],
    );
  }
}
