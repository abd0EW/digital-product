import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/repositories/edit_profile/edit_profile_repository.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this._repository);

  final EditProfileRepository _repository;

  Future<Either<ProfileFailure, EditProfileUpdateResult>> call({
    required ProfileModel profile,
    Uint8List? imageBytes,
    String? imageExtension,
    String? contentType,
  }) {
    return _repository.updateProfile(
      profile: profile,
      imageBytes: imageBytes,
      imageExtension: imageExtension,
      contentType: contentType,
    );
  }

  Future<bool> updateEmailProfile({required ProfileModel profile}) async {
    final isUpdateEmail = _repository.updateEmailProfile(email: profile.email!);
    return isUpdateEmail;
  }
}
