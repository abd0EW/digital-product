import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/logout/logout_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/logout/logout_state.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_state.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_header.dart';
import 'package:digital_product/features/auth/presentation/widgets/password_text_field.dart';
import 'package:digital_product/features/auth/presentation/widgets/responsive_auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WorkerSetPasswordView extends StatefulWidget {
  const WorkerSetPasswordView({super.key});

  @override
  State<WorkerSetPasswordView> createState() => _WorkerSetPasswordViewState();
}

class _WorkerSetPasswordViewState extends State<WorkerSetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _verifiedEmail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVerifiedEmail();
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadVerifiedEmail() async {
    final email = await context
        .read<PasswordCubit>()
        .getVerifiedAuthenticatedUserEmail();
    if (!mounted) return;

    setState(() {
      _verifiedEmail = email;
    });
  }

  void _setPassword() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<PasswordCubit>().setInvitedWorkerPassword(
      password: _passwordController.text,
    );
  }

  void _onPasswordSet(BuildContext context) {
    AppSnackbar.success(context, message: 'تم تعيين كلمة المرور بنجاح.');
    context.read<LogoutCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PasswordCubit, PasswordState>(
          listener: (context, state) {
            if (state is InvitedWorkerPasswordFailure) {
              AppSnackbar.error(context, message: state.message);
            } else if (state is InvitedWorkerPasswordSet) {
              _onPasswordSet(context);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: ResponsiveAuthLayout(
                      centerVertically: true,
                      child: Form(
                        key: _formKey,
                        child: BlocBuilder<PasswordCubit, PasswordState>(
                          builder: (context, state) {
                            final isLoading = state is PasswordLoading;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const AuthHeader(),
                                const Gap(AppSpacing.xl),
                                const AppText.title(
                                  'تعيين كلمة المرور',
                                  textAlign: TextAlign.right,
                                ),
                                const Gap(AppSpacing.xs),
                                const AppText.body(
                                  'أنشئ كلمة مرور لحساب العامل المدعو.',
                                  color: AppColors.bodyText,
                                  textAlign: TextAlign.right,
                                ),
                                if (_verifiedEmail case final email?) ...[
                                  const Gap(AppSpacing.md),
                                  AppText.body(
                                    'البريد الإلكتروني: $email',
                                    color: AppColors.bodyText,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                                const Gap(AppSpacing.lg),
                                const AppText.title(
                                  'كلمة المرور الجديدة',
                                  textAlign: TextAlign.right,
                                ),
                                const Gap(AppSpacing.xs),
                                PasswordTextField(
                                  controller: _passwordController,
                                  hintText: 'كلمة المرور الجديدة',
                                ),
                                const Gap(AppSpacing.md),
                                const AppText.title(
                                  'تأكيد كلمة المرور',
                                  textAlign: TextAlign.right,
                                ),
                                const Gap(AppSpacing.xs),
                                PasswordTextField(
                                  controller: _confirmPasswordController,
                                  hintText: 'أعد كتابة كلمة المرور',
                                  validator: (value) =>
                                      AppValidators.confirmPassword(
                                        value,
                                        _passwordController.text,
                                      ),
                                ),
                                const Gap(AppSpacing.lg),
                                AppButton(
                                  title: 'حفظ كلمة المرور',
                                  onPressed: isLoading ? null : _setPassword,
                                  isLoading: isLoading,
                                  backgroundColor: AppColors.headingText,
                                  foregroundColor: AppColors.appBackground,
                                ),
                              ],
                            );
                          },
                        ),
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
