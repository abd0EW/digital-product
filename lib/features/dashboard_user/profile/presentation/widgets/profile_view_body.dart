import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_state.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_content.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final horizontalPadding = width < 600 ? AppSpacing.md : AppSpacing.xl;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(builder: (_) => const AuthView()),
            (route) => false,
          );
        } else if (state is ProfileLogoutFailure) {
          AppSnackbar.error(context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  AppSpacing.md,
                  horizontalPadding,
                  0,
                ),
                sliver: const SliverToBoxAdapter(child: ProfileContent()),
              ),

              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    AppSpacing.md,
                    horizontalPadding,
                    AppSpacing.md,
                  ),
                  child: const Column(
                    children: [Spacer(), ProfileLogoutButton()],
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
