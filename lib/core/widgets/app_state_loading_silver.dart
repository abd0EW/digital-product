import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStateLoadingSilver extends StatelessWidget {
  const AppStateLoadingSilver({super.key});

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
