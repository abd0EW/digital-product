import 'dart:typed_data';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_header.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_logout_button.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_menu_card.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_user_card.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final ProfileModel profileModel;

  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();

    profileModel = ProfileModel(
      email: 'Abdulrahman@gmail.com',
      name: 'ramzy',
      phone: '01011540321',
      isEditing: false,
    );

    _nameController = TextEditingController(text: profileModel.name ?? '');

    _phoneController = TextEditingController(text: profileModel.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _startEditing() {
    _nameController.text = profileModel.name ?? '';
    _phoneController.text = profileModel.phone ?? '';

    setState(() {
      profileModel.isEditing = true;
    });
  }

  void _cancelEditing() {
    _nameController.text = profileModel.name ?? '';
    _phoneController.text = profileModel.phone ?? '';

    _unfocus();

    setState(() {
      profileModel.isEditing = false;
    });
  }

  void _saveProfile() {
    _unfocus();

    setState(() {
      profileModel
        ..name = _nameController.text.trim()
        ..phone = _phoneController.text.trim()
        ..isEditing = false;
    });
  }

  void _onAvatarChanged(Uint8List bytes) {
    setState(() => _avatarBytes = bytes);
  }

  void _unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onMenuItemPressed(String title) {}

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.sizeOf(context).width < 600
        ? AppSpacing.md
        : AppSpacing.xl;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  AppSpacing.md,
                  horizontalPadding,
                  0,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const ProfileHeader(),
                    const SizedBox(height: AppSpacing.md),

                    ProfileUserCard(
                      profileModel: profileModel,
                      nameController: _nameController,
                      phoneController: _phoneController,
                      avatarBytes: _avatarBytes,
                      onAvatarChanged: _onAvatarChanged,
                      onEditPressed: _startEditing,
                      onSavePressed: _saveProfile,
                      onCancelPressed: _cancelEditing,
                    ),

                    const SizedBox(height: AppSpacing.md),

                    ProfileMenuCard(onItemPressed: _onMenuItemPressed),
                  ]),
                ),
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
