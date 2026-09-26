import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/features/auth/domain/entities/profile_entity.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/views/owner_root_view.dart';
import 'package:digital_product/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatedRootView extends StatelessWidget {
  const AuthenticatedRootView({required this.profile, super.key});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(builder: (_) => const AuthView()),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: switch (profile.role) {
        UserRole.user => const UserRootView(),
        UserRole.owner => const OwnerRootView(),
        UserRole.worker => const _UnsupportedRoleView(),
      },
    );
  }
}

class _UnsupportedRoleView extends StatelessWidget {
  const _UnsupportedRoleView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('نوع الحساب غير متاح حالياً'),
              const SizedBox(height: 16),
              AppButton(
                title: 'تسجيل الخروج',
                onPressed: () => context.read<AuthCubit>().logout(),
                backgroundColor: AppColors.primaryButtonBackground,
                foregroundColor: AppColors.primaryButtonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
