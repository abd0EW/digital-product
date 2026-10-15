import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/domain/failures/failure.dart';
import 'package:digital_product/features/dashboard_user/services/domain/repositories/services_repository.dart';

class GetServicesUseCase {
  final ServicesRepository _servicesRepository;
  GetServicesUseCase({required this._servicesRepository});

  Future<Either<Failure, List<ServiceModel>>> getServices() async {
    return await _servicesRepository.getServices();
  }
}
