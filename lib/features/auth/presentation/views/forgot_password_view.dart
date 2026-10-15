import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,

    required this.newPasswordController,
    required this.onUpdatePasswordPressed,
  });

  final TextEditingController newPasswordController;
  final VoidCallback onUpdatePasswordPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.lock_reset_rounded,
                    size: 72,
                    color: AppColors.primaryButtonBackground,
                  ),

                  const SizedBox(height: 28),

                  AppText.title('إنشاء كلمة مرور جديدة'),

                  const SizedBox(height: 12),

                  AppText.body(
                    'أدخل كلمة المرور الجديدة لحسابك، ثم أكدها مرة أخرى.',
                  ),

                  const SizedBox(height: 32),

                  AppTextField(
                    controller: newPasswordController,
                    hintText: 'كلمة المرور الجديدة',
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),

                  const SizedBox(height: 24),

                  AppButton(
                    title: 'تحديث كلمة المرور',
                    onPressed: onUpdatePasswordPressed,
                    backgroundColor: AppColors.primaryButtonBackground,
                    foregroundColor: AppColors.appBackground,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
