import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:digital_product/features/auth/presentation/views/login_view.dart';
import 'package:digital_product/features/auth/presentation/views/register_view.dart';
import 'package:digital_product/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  final int initialIndex;

  const AuthView({super.key, this.initialIndex = 0});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
  }

  void _goToRegister() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_currentIndex == 1) return;

    setState(() {
      _currentIndex = 1;
    });
  }

  void _goToLogin() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_currentIndex == 0) return;

    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          AppSnackbar.error(context, message: state.message.toString());
        }

        if (state is AuthRegistrationSuccess) {
          AppSnackbar.success(
            context,
            message: "تم إنشاء الحساب بنجاح، تحقق من بريدك الإلكتروني",
          );
          _goToLogin();
        }

        if (state is AuthLoginSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserRootView()),
          );
        }
      },
      child: IndexedStack(
        index: _currentIndex,
        children: [
          LoginView(onRegisterPressed: _goToRegister),
          RegisterView(onLoginPressed: _goToLogin),
        ],
      ),
    );
  }
}
