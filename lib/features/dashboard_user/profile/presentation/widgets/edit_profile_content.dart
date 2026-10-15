import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/edit_profile_cubit/edit_profile_state.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/edit_profile_form_card.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/edit_profile_header.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileContent extends StatelessWidget {
  const EditProfileContent({
    super.key,
    required this.profile,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
  });

  final ProfileModel profile;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final isSaving = state is EditProfileLoading;
        final editCubit = context.read<EditProfileCubit>();

        return Column(
          children: [
            EditProfileHeader(isSaving: isSaving),

            const SizedBox(height: AppSpacing.md),

            ProfileAvatarPicker(
              avatarBytes: editCubit.selectedImageBytes,
              avatarUrl: profile.imageUrl,
              enabled: !isSaving,
              onAvatarChanged:
                  ({required bytes, required extension, required contentType}) {
                    editCubit.selectProfileImage(
                      bytes: bytes,
                      extension: extension,
                      contentType: contentType,
                    );
                  },
            ),

            const SizedBox(height: AppSpacing.md),

            EditProfileFormCard(
              nameController: nameController,
              phoneController: phoneController,
              emailController: emailController,
              isSaving: isSaving,
              onSave: () {
                final updatedProfile = ProfileModel(
                  email: emailController.text.trim(),
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  imageUrl: profile.imageUrl,
                );

                _saveProfile(context, updatedProfile);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfile(BuildContext context, ProfileModel profile) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final editCubit = context.read<EditProfileCubit>();

    final isEmailChanged =
        profile.email?.trim().toLowerCase() !=
        this.profile.email?.trim().toLowerCase();

    await editCubit.updateProfile(
      profile: profile,
      isEmailChanged: isEmailChanged,
    );
  }
}
