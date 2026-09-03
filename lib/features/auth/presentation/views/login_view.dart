import 'package:digital_product/features/auth/presentation/views/register_view.dart';
import 'package:digital_product/features/auth/presentation/widgets/login_fields.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/auth_header.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    print('LoginView build called');
    print('===================================================');
    return Scaffold(
      backgroundColor: AppColors.appBackground,

      body: Center(
        child: SafeArea(
          top: false,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth < 420
                    ? 20.0
                    : 28.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    AppSpacing.sm,
                    horizontalPadding,
                    AppSpacing.xl,
                  ),

                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const AuthHeader(),

                          const Gap(AppSpacing.xl),

                          const AppText(
                            'تسجيل الدخول',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.right,
                          ),

                          const Gap(AppSpacing.xs),

                          const AppText(
                            'أدخل بيانات حسابك للمتابعة',
                            fontSize: 14,

                            color: AppColors.bodyText,
                            textAlign: TextAlign.right,
                          ),

                          const Gap(AppSpacing.md),
                          LoginFields(
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          const Gap(AppSpacing.sm),

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: TextButton(
                              onPressed: () {},
                              child: const AppText(
                                'نسيت كلمة المرور؟',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                usePrimaryColor: false,
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.sm),

                          AppButton(
                            title: 'تسجيل الدخول',
                            onPressed: _validateForm,
                            backgroundColor: AppColors.headingText,
                            foregroundColor: AppColors.appBackground,
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const AppText(
                                  'ليس لديك حساب؟ ',
                                  fontSize: 14,
                                  height: 1.5,
                                  color: AppColors.bodyText,
                                ),
                                InkWell(
                                  child: AppText(
                                    'إنشاء حساب جديد',
                                    fontSize: 14,
                                    color: AppColors.tealPrimary,
                                    fontWeight: FontWeight.w700,
                                    usePrimaryColor: false,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterView(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
