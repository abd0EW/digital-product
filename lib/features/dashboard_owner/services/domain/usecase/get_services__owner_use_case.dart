import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/services/domain/repositories/owner_services_repo.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/domain/failures/failure.dart';

class GetServicesOwnerUseCase {
  final OwnerServicesRepo repository;

  GetServicesOwnerUseCase(this.repository);

  Future<Either<Failure, List<ServiceModel>>> getServices() async {
    return await repository.getServices();
  }
}
