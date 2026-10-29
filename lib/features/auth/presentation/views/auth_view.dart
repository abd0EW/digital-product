import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/utils/role_navigation_resolver.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_state.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/register/register_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/register/register_state.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/user_role/user_role_cubit.dart';
import 'package:digital_product/features/auth/presentation/views/login_view.dart';
import 'package:digital_product/features/auth/presentation/views/register_view.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/confirm_worker_invitation_cubit/confirm_worker_invitation_cubit.dart';

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

  Future<void> _handleLoginSuccess(BuildContext context) async {
    final userRoleCubit = context.read<UserRoleCubit>();
    final confirmWorkerCubit = context.read<ConfirmWorkerInvitationCubit>();

    final role = await userRoleCubit.getCurrentUserRole();

    if (!context.mounted) return;

    if (role == null) {
      AppSnackbar.error(context, message: 'تعذر تحديد صلاحية المستخدم');
      return;
    }

    if (role == UserRole.worker) {
      await confirmWorkerCubit.confirmWorkerInvitation();

      if (!context.mounted) return;
    }

    final destination = RoleNavigationResolver.resolve(context, role);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: destination!),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginFailure) {
              AppSnackbar.error(context, message: state.message);
            }

            if (state is LoginSuccess) {
              await _handleLoginSuccess(context);
            }
          },
        ),
        BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              AppSnackbar.error(context, message: state.message);
            }

            if (state is RegisterSuccess) {
              AppSnackbar.success(
                context,
                message: "تم إنشاء الحساب بنجاح، تحقق من بريدك الإلكتروني",
              );
              _goToLogin();
            }
          },
        ),
      ],
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
