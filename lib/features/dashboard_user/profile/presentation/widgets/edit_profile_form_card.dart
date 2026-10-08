import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_edit_form.dart';
import 'package:flutter/material.dart';

class EditProfileFormCard extends StatelessWidget {
  const EditProfileFormCard({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ProfileEditForm(
        nameController: nameController,
        phoneController: phoneController,
        emailController: emailController,
        isSaving: isSaving,
        onSave: onSave,
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
