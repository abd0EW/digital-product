import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterActionsSection extends StatelessWidget {
  const RegisterActionsSection({
    super.key,
    required this.onRegisterPressed,
    required this.goToLogin,
  });
  final VoidCallback goToLogin;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          width: double.infinity,
          title: 'إنشاء الحساب',
          onPressed: onRegisterPressed,
          backgroundColor: AppColors.primaryButtonBackground,
          foregroundColor: AppColors.whiteText,
        ),

        const Gap(AppSpacing.xs),

        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const AppText.body(
                'لديك حساب بالفعل؟ ',
                color: AppColors.bodyText,
              ),

              InkWell(
                onTap: goToLogin,
                child: const AppText.title(
                  'تسجيل الدخول',
                  color: AppColors.tealPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
