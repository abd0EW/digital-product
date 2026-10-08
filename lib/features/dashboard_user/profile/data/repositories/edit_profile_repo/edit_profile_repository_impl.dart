import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/data/remote_data_source/edit_profile/edit_profile_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/repositories/edit_profile/edit_profile_repository.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  const EditProfileRepositoryImpl({required this._editProfileRemoteDataSource});
  final EditProfileRemoteDataSource _editProfileRemoteDataSource;

  @override
  Future<Either<ProfileFailure, EditProfileUpdateResult>> updateProfile({
    required ProfileModel profile,
    Uint8List? imageBytes,
    String? imageExtension,
    String? contentType,
  }) async {
    try {
      final cleanupWarning = await _editProfileRemoteDataSource.updateProfile(
        profile: profile,
        imageBytes: imageBytes,
        imageExtension: imageExtension,
        contentType: contentType,
      );
      return Right(EditProfileUpdateResult(cleanupWarning: cleanupWarning));
    } on Exception catch (exception) {
      return Left(ProfileFailure(message: exception.toString()));
    }
  }

  @override
  Future<bool> updateEmailProfile({required String email}) async {
    try {
      final response = await _editProfileRemoteDataSource.updateEmailProfile(
        email: email,
      );
      return response;
    } catch (e) {
      return false;
    }
  }
}
