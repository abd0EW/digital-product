import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/domain/failures/failure.dart';

abstract class OwnerServicesRepo {
  Future<void> updateServiceActive({
    required String serviceId,
    required bool isActive,
  });

  Future<Either<Failure, List<ServiceModel>>> getServices();
}
