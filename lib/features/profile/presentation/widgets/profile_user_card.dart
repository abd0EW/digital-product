import 'dart:typed_data';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/profile/data/models/profile_model.dart';
import 'package:digital_product/features/profile/presentation/widgets/profile_avatar_picker.dart';
import 'package:digital_product/features/profile/presentation/widgets/profile_edit_form.dart';
import 'package:digital_product/features/profile/presentation/widgets/profile_info_row.dart';
import 'package:flutter/material.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    required this.profileModel,
    required this.phoneController,
    required this.avatarBytes,
    required this.onAvatarChanged,
    required this.onEditPressed,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.nameController,
    super.key,
  });

  final ProfileModel profileModel;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Uint8List? avatarBytes;
  final ValueChanged<Uint8List> onAvatarChanged;
  final VoidCallback onEditPressed;
  final VoidCallback onSavePressed;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              alignment: Alignment.topCenter,
              child: child,
            ),
          );
        },
        child: profileModel.isEditing
            ? ProfileEditForm(
                key: const ValueKey('profile-edit'),
                nameController: nameController,
                phoneController: phoneController,
                email: profileModel.email ?? 'Guest@gmail.com',
                onSave: onSavePressed,
                onCancel: onCancelPressed,
              )
            : _ProfileInfoSummary(
                key: const ValueKey('profile-info'),
                profileModel: profileModel,
                avatarBytes: avatarBytes,
                onAvatarChanged: onAvatarChanged,
                onEditPressed: onEditPressed,
              ),
      ),
    );
  }
}

class _ProfileInfoSummary extends StatelessWidget {
  const _ProfileInfoSummary({
    required this.profileModel,
    required this.avatarBytes,
    required this.onAvatarChanged,
    required this.onEditPressed,
    super.key,
  });

  final ProfileModel profileModel;
  final Uint8List? avatarBytes;
  final ValueChanged<Uint8List> onAvatarChanged;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatarPicker(
              avatarBytes: avatarBytes,
              onAvatarChanged: onAvatarChanged,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(
                    profileModel.name ?? 'Guest',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  AppText.switches(
                    profileModel.email ?? 'Guest@gmail.com',
                    color: AppColors.bodyText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ProfileInfoRow(
          label: 'الاسم',
          value: profileModel.name ?? 'Guest',
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: AppSpacing.sm),
        ProfileInfoRow(
          label: 'البريد الإلكتروني',
          value: profileModel.email ?? 'Guest@gmail.com',
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: AppSpacing.sm),
        ProfileInfoRow(
          label: 'رقم الجوال',
          value: profileModel.phone ?? '0',
          icon: Icons.phone_outlined,
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
          child: AppButton(
            width: double.infinity,
            backgroundColor: AppColors.primaryButtonBackground,
            foregroundColor: AppColors.appBackground,
            icon: const Icon(Icons.edit_outlined, size: 18),
            title: 'تعديل الملف الشخصي',
            onPressed: onEditPressed,
          ),
        ),
      ],
    );
  }
}
