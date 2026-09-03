import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.navyPrimary,
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: const Icon(
            Icons.description_outlined,
            color: AppColors.whiteText,
            size: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const AppText(
          'منصة الخدمات الرقمية',
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
