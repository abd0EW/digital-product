import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.profile);

  final ProfileModel profile;
}

final class ProfileLogoutLoading extends ProfileState {
  const ProfileLogoutLoading(this.profile);

  final ProfileModel profile;
}

final class ProfileLogoutSuccess extends ProfileState {
  const ProfileLogoutSuccess();
}

final class ProfileLogoutFailure extends ProfileState {
  const ProfileLogoutFailure({required this.profile, required this.message});

  final ProfileModel profile;
  final String message;
}

final class ProfileSaving extends ProfileState {
  const ProfileSaving();
}

final class ProfileUpdated extends ProfileState {
  const ProfileUpdated({
    required this.profile,
    required this.emailConfirmationRequired,
  });

  final ProfileModel profile;
  final bool emailConfirmationRequired;
}

final class ProfileFailureState extends ProfileState {
  const ProfileFailureState(this.message);

  final String message;
}
