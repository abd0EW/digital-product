import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppBottomSheetContainer extends StatelessWidget {
  const AppBottomSheetContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(26),
      ),
      child: child,
    );
  }
}
