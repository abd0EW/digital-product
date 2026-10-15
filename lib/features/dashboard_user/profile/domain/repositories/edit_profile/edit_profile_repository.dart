import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';

class EditProfileUpdateResult {
  const EditProfileUpdateResult({this.cleanupWarning});

  final String? cleanupWarning;
}

abstract interface class EditProfileRepository {
  Future<Either<ProfileFailure, EditProfileUpdateResult>> updateProfile({
    required ProfileModel profile,
    Uint8List? imageBytes,
    String? imageExtension,
    String? contentType,
  });

  Future<bool> updateEmailProfile({required String email});
}
