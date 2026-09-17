import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_header.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_switch_row.dart';
import 'package:digital_product/features/auth/presentation/widgets/login_fields.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onForgotPasswordPressed;

  const LoginContent({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onForgotPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        const AuthHeader(),

        const Gap(AppSpacing.xl),

        const AppText.title('تسجيل الدخول', textAlign: TextAlign.right),

        const Gap(AppSpacing.xs),

        const AppText.body(
          'أدخل بيانات حسابك للمتابعة',
          color: AppColors.bodyText,
          textAlign: TextAlign.right,
        ),

        const Gap(AppSpacing.md),

        LoginFields(
          emailController: emailController,
          passwordController: passwordController,
        ),

        const Gap(AppSpacing.xs),

        Align(
          alignment: AlignmentDirectional.centerStart,

          child: TextButton(
            onPressed: onForgotPasswordPressed,

            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            child: const AppText.caption('نسيت كلمة المرور؟'),
          ),
        ),

        const Gap(AppSpacing.md),

        AppButton(
          title: 'تسجيل الدخول',
          onPressed: onLoginPressed,
          backgroundColor: AppColors.headingText,
          foregroundColor: AppColors.appBackground,
        ),

        const Gap(AppSpacing.xl),

        AuthSwitchRow(
          text: 'ليس لديك حساب؟',
          actionText: 'إنشاء حساب جديد',
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}
