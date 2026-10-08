import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_state.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileSuccess() => ProfileDataView(profile: state.profile),

          ProfileLogoutLoading() => ProfileDataView(profile: state.profile),

          ProfileLogoutFailure() => ProfileDataView(profile: state.profile),

          ProfileFailureState() => Center(child: AppText.title(state.message)),

          _ => const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryButtonBackground,
            ),
          ),
        };
      },
    );
  }
}
