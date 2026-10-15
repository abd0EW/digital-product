import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/views/edit_profile_view.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_header.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDataView extends StatelessWidget {
  final ProfileModel profile;

  const ProfileDataView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileHeader(),

        const SizedBox(height: AppSpacing.md),

        ProfileUserCard(
          profileModel: profile,
          onEditPressed: () {
            _openEditProfile(context);
          },
        ),
      ],
    );
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final profileCubit = context.read<ProfileCubit>();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: profileCubit,
            child: EditProfileView(profile: profile),
          );
        },
      ),
    );
  }
}
