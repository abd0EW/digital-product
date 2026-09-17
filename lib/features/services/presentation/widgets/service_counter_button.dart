import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceCounterButton extends StatelessWidget {
  const ServiceCounterButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.navyPrimary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
          border: isPrimary ? null : Border.all(color: AppColors.inputBorder),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 17,
          color: isPrimary ? AppColors.whiteText : AppColors.headingText,
        ),
      ),
    );
  }
}
