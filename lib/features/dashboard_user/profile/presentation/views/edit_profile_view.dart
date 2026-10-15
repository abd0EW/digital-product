import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return EditProfileViewBody(profile: profile);
  }
}
