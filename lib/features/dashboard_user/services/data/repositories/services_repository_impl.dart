import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/services_repository.dart';
import '../remote_data_source/services_remote_data_source.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesRemoteDataSource _remoteDataSource;

  ServicesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ServiceModel>>> getServices() async {
    try {
      final models = await _remoteDataSource.getServices();
      final response = models
          .map((model) => model)
          .cast<ServiceModel>()
          .toList();

      return Right(response);
    } on Exception catch (exception) {
      return Left(
        ServiceFailure(message: exception.toString(), exception: exception),
      );
    }
  }
}
