



import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';

sealed class EditProfileState {
  const EditProfileState();
}

final class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

final class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

final class EditProfileImageSelected extends EditProfileState {
  const EditProfileImageSelected();
}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess({
    required this.profile,
    required this.emailConfirmationRequired,
    this.cleanupWarning,
  });

  final ProfileModel profile;
  final bool emailConfirmationRequired;
  final String? cleanupWarning;
}

final class EditProfileFailure extends EditProfileState {
  const EditProfileFailure({
    required this.message,
  });

  final String message;
}