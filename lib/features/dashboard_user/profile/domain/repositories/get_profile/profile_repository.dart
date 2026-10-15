import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';

typedef ProfileUpdateResult = ({
  ProfileModel profile,
  bool emailConfirmationRequired,
});

abstract interface class ProfileRepository {
  Future<Either<ProfileFailure, ProfileModel>> getProfile();
  Future<Either<ProfileFailure, void>> logout();
}
