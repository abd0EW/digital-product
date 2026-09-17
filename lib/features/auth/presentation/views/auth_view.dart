import 'package:digital_product/features/auth/presentation/views/login_view.dart';
import 'package:digital_product/features/auth/presentation/views/register_view.dart';
import 'package:flutter/material.dart';

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
    return IndexedStack(
      index: _currentIndex,
      children: [
        LoginView(onRegisterPressed: _goToRegister),

        RegisterView(onLoginPressed: _goToLogin),
      ],
    );
  }
}
