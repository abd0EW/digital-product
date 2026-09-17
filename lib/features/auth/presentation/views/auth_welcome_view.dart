import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class AuthWelcomeView extends StatelessWidget {
  const AuthWelcomeView({super.key});

  void _openAuth(BuildContext context, {required int initialIndex}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AuthView(initialIndex: initialIndex)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 600 ? 20.0 : 48.0;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  AppSpacing.xl,
                  horizontalPadding,
                  AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AuthHeader(),

                      const SizedBox(height: AppSpacing.xxl),

                      const AppText.title(
                        'أهلاً وسهلاً',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      const AppText.body(
                        'سجل دخولك أو أنشئ حساباً جديداً للاستفادة من خدماتنا',
                        color: AppColors.bodyText,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      AppButton(
                        width: double.infinity,
                        backgroundColor: AppColors.headingText,
                        foregroundColor: AppColors.appBackground,
                        title: 'تسجيل الدخول',
                        onPressed: () {
                          _openAuth(context, initialIndex: 0);
                        },
                      ),

                      const SizedBox(height: AppSpacing.md),

                      AppButton(
                        borderColor: AppColors.inputBorder,
                        width: double.infinity,
                        backgroundColor: AppColors.cardBackground,
                        foregroundColor: AppColors.headingText,
                        title: 'إنشاء حساب جديد',
                        onPressed: () {
                          _openAuth(context, initialIndex: 1);
                        },
                      ),

                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
