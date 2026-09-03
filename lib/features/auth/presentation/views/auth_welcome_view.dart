import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/auth_header.dart';
import 'login_view.dart';

class AuthWelcomeView extends StatelessWidget {
  const AuthWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth < 420
                  ? 20.0
                  : 28.0;
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    AppSpacing.xl,
                    horizontalPadding,
                    AppSpacing.lg,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Column(
                        children: [
                          const AuthHeader(),
                          const SizedBox(height: AppSpacing.xxl),
                          const AppText(
                            'أهلاً وسهلاً',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const AppText(
                            'سجل دخولك أو أنشئ حساباً جديداً للاستفادة من خدماتنا',
                            fontSize: 15,
                            height: 1.6,
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
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const LoginView(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppButton(
                            borderColor: AppColors.inputBorder,
                            width: double.infinity,
                            backgroundColor: AppColors.cardBackground,
                            foregroundColor: AppColors.headingText,
                            title: 'إنشاء حساب جديد',
                            onPressed: () {},
                          ),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
