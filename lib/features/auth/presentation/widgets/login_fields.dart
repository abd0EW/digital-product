import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:digital_product/features/auth/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.title('البريد الإلكتروني', textAlign: TextAlign.right),

        const Gap(10),

        AppTextField(
          hintText: 'البريد الإلكتروني',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: AppValidators.email,
        ),

        const Gap(AppSpacing.md),

        const AppText.title('كلمة المرور', textAlign: TextAlign.right),

        const Gap(AppSpacing.xs),

        PasswordTextField(controller: passwordController),
      ],
    );
  }
}
