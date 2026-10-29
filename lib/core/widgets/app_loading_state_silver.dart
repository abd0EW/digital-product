import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingStateSilver extends StatelessWidget {
  const AppLoadingStateSilver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryButtonBackground,
        ),
      ),
    );
  }
}
