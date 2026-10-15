import 'package:dartz/dartz.dart';
import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

import 'package:digital_product/features/dashboard_owner/services/data/datasources/owner_services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_user/services/domain/failures/failure.dart';

import '../../domain/repositories/owner_services_repo.dart';

class OwnerServicesRepoImpl implements OwnerServicesRepo {
  final OwnerServicesRemoteDataSource remoteDataSource;

  OwnerServicesRepoImpl(this.remoteDataSource);

  @override
  Future<void> updateServiceActive({
    required String serviceId,
    required bool isActive,
  }) async {
    await remoteDataSource.updateServiceActive(
      serviceId: serviceId,
      isActive: isActive,
    );
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getServices() async {
    try {
      final response = await remoteDataSource.getServices();
      return Right(response);
    } on Exception catch (exception) {
      return Left(
        ServiceFailure(message: exception.toString(), exception: exception),
      );
    }
  }
}
