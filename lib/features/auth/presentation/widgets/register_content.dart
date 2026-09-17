import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/auth/presentation/widgets/acount_type.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_header.dart';
import 'package:digital_product/features/auth/presentation/widgets/register_actions_section.dart';
import 'package:digital_product/features/auth/presentation/widgets/register_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterContent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  final ValueListenable<AcountType> accountType;
  final VoidCallback goToLogin;
  final ValueChanged<AcountType> onAccountTypeChanged;
  final VoidCallback onRegisterPressed;

  const RegisterContent({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.accountType,
    required this.onAccountTypeChanged,
    required this.onRegisterPressed,
    required this.goToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AuthHeader(),

        const Gap(AppSpacing.xs),

        const AppText.body(
          'أدخل بياناتك لإنشاء حساب جديد',
          color: AppColors.bodyText,
          textAlign: TextAlign.right,
        ),

        const Gap(AppSpacing.sm),

        AccountTypeSelector(
          valueListenable: accountType,
          onChanged: onAccountTypeChanged,
        ),

        const Gap(AppSpacing.lg),

        RegisterFields(
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
          passwordController: passwordController,
        ),

        RegisterActionsSection(
          goToLogin: goToLogin,

          onRegisterPressed: onRegisterPressed,
        ),
      ],
    );
  }
}
