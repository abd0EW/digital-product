import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/repositories/get_profile/profile_repository.dart';

class GetProfileUseCase {
  GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<ProfileFailure, ProfileModel>> call() {
    return _repository.getProfile();
  }
}
