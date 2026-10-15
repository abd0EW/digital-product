import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/data/remote_data_source/get_profile.dart/get_profile_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/failures/profile_failure.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/repositories/get_profile/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<ProfileFailure, ProfileModel>> getProfile() async {
    try {
      final response = await _remoteDataSource.getProfile();
      print("inrepo is skffjjfs");
      print(response.email);
      print(response.name);
      print(response.phone);
      return Right(response);
    } on Exception catch (exception) {
      return Left(ProfileFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<ProfileFailure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      return const Right(null);
    } on Exception catch (exception) {
      return Left(ProfileFailure(message: exception.toString()));
    }
  }
}
