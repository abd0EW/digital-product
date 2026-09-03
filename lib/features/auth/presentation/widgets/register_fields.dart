import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:digital_product/features/auth/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'الاسم الكامل',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.right,
        ),

        const Gap(10),

        AppTextField(
          controller: nameController,
          hintText: 'اكتب اسمك الكامل',

          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: AppValidators.requiredField,
        ),

        const Gap(AppSpacing.md),

        const AppText(
          'البريد الإلكتروني',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.right,
        ),

        const Gap(10),

        AppTextField(
          controller: emailController,
          hintText: 'أدخل بريدك الإلكتروني',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: AppValidators.email,
        ),

        const Gap(AppSpacing.md),

        const AppText(
          'رقم الجوال',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.right,
        ),

        const Gap(10),

        AppTextField(
          controller: phoneController,
          hintText: '05XXXXXXXX',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: AppValidators.requiredField,
        ),

        const Gap(AppSpacing.md),

        const AppText(
          'كلمة المرور',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.right,
        ),

        const Gap(10),

        PasswordTextField(controller: passwordController),

        const Gap(AppSpacing.lg),
      ],
    );
  }
}
