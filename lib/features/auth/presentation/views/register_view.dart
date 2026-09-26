import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:digital_product/features/auth/presentation/widgets/acount_type.dart';
import 'package:digital_product/features/auth/presentation/widgets/register_content.dart';
import 'package:digital_product/features/auth/presentation/widgets/responsive_auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const RegisterView({super.key, required this.onLoginPressed});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<AcountType> _accountType = ValueNotifier<AcountType>(
    AcountType.user,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accountType.dispose();

    super.dispose();
  }

  void _validateForm() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<AuthCubit>().register(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      role: _getUserRole(),
    );
  }

  UserRole _getUserRole() {
    switch (_accountType.value) {
      case AcountType.user:
        return UserRole.user;

      case AcountType.owner:
        return UserRole.owner;
      case AcountType.worker:
        return UserRole.worker;
    }
  }

  void _changeAccountType(AcountType accountType) {
    _accountType.value = accountType;
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
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(
                child: ResponsiveAuthLayout(
                  centerVertically: false,
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return RegisterContent(
                          nameController: _nameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          accountType: _accountType,
                          onAccountTypeChanged: _changeAccountType,
                          onRegisterPressed: _validateForm,
                          goToLogin: widget.onLoginPressed,
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
