import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_state.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_state.dart';
import 'package:digital_product/features/auth/presentation/views/forgot_password_view.dart';
import 'package:digital_product/features/auth/presentation/widgets/login_content.dart';
import 'package:digital_product/features/auth/presentation/widgets/responsive_auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.onRegisterPressed, this.userRole});

  final VoidCallback onRegisterPressed;
  final UserRole? userRole;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  void _validateLoginForm() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _forgotPassword() {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.warning(context, message: 'أدخل بريدك الإلكتروني أولًا.');
      return;
    }
    context.read<PasswordCubit>().forgotPassword(email: email);
  }

  void _updatePassword() {
    context.read<PasswordCubit>().updatePassword(
      newPassword: newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordCubit, PasswordState>(
      listener: (context, state) {
        if (state is PasswordFailure) {
          AppSnackbar.error(context, message: state.message);
        }

        if (state is PasswordResetEmailSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordView(
                newPasswordController: newPasswordController,
                onUpdatePasswordPressed: _updatePassword,
              ),
            ),
          );
        }

        if (state is PasswordUpdated) {
          AppSnackbar.success(context, message: 'تم تحديث كلمة المرور بنجاح.');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverToBoxAdapter(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: ResponsiveAuthLayout(
                          centerVertically: true,
                          child: Form(
                            key: _formKey,
                            child: BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                return LoginContent(
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                  onLoginPressed: _validateLoginForm,
                                  onForgotPasswordPressed: _forgotPassword,
                                  onRegisterPressed: widget.onRegisterPressed,
                                  isLoading: state is LoginLoading,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
