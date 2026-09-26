import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:digital_product/features/auth/presentation/widgets/login_content.dart';
import 'package:digital_product/features/auth/presentation/widgets/responsive_auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  final VoidCallback onRegisterPressed;

  const LoginView({super.key, required this.onRegisterPressed});

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
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return LoginContent(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                onLoginPressed: _validateForm,
                                onForgotPasswordPressed: () {},
                                onRegisterPressed: widget.onRegisterPressed,
                                isLoading: state is AuthLoading,
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
    );
  }
}
