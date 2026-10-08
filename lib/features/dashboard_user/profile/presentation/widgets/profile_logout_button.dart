import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isLoading = state is ProfileLogoutLoading;
        final canLogout =
            state is ProfileSuccess || state is ProfileLogoutFailure;

        return AppButton(
          title: 'تسجيل الخروج',
          onPressed: !canLogout || isLoading
              ? null
              : () => context.read<ProfileCubit>().logout(),
          isLoading: isLoading,
          width: double.infinity,
          height: 50,
          backgroundColor: const Color.fromRGBO(214, 58, 58, 1),
          foregroundColor: AppColors.appBackground,
          borderColor: const Color(0xFFF2CACA),
          icon: const Icon(Icons.logout_rounded),
        );
      },
    );
  }
}
