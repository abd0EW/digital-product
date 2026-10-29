import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/utils/role_navigation_resolver.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/user_role/user_role_cubit.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _isInitializing = true;
  UserRole? _currentUserRole;

  @override
  void initState() {
    super.initState();
    _initializeUserSession();
  }

  Future<void> _initializeUserSession() async {
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;

      if (currentUser == null) {
        if (!mounted) return;

        setState(() {
          _currentUserRole = null;
          _isInitializing = false;
        });

        return;
      }

      final resolvedRole = await context
          .read<UserRoleCubit>()
          .getCurrentUserRole();

      if (!mounted) return;

      setState(() {
        _currentUserRole = resolvedRole;
        _isInitializing = false;
      });
    } catch (error, stackTrace) {
      debugPrint('Session initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        _currentUserRole = null;
        _isInitializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const ColoredBox(
        color: AppColors.appBackground,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryButtonBackground,
          ),
        ),
      );
    }

    final currentRole = _currentUserRole;

    if (currentRole == null) {
      return const AuthView();
    }

    final destinationBuilder = RoleNavigationResolver.resolve(
      context,
      currentRole,
    );

    return destinationBuilder?.call(context) ?? const AuthView();
  }
}
