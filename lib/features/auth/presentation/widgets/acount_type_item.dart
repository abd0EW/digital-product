import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AccountTypeItem extends StatelessWidget {
  const AccountTypeItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.successBackground
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: isSelected ? AppColors.tealPrimary : AppColors.inputBorder,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.tealPrimary : AppColors.bodyText,
              ),

              const SizedBox(width: 7),

              Icon(
                icon,
                size: 17,
                color: isSelected ? AppColors.tealPrimary : AppColors.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
