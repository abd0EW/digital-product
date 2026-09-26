import 'dart:async';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:digital_product/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const Duration _splashDuration = Duration(seconds: 2);
  static const Duration _animationDuration = Duration(milliseconds: 700);

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(_splashDuration, _openLogin);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _openLogin() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AuthView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: _animationDuration,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.92 + (0.08 * value),
                  child: child,
                ),
              );
            },
            child: const AuthHeader(),
          ),
        ),
      ),
    );
  }
}
