import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

abstract class OwnerServicesRemoteDataSource {
  Future<List<ServiceModel>> getServices();

  Future<void> updateServiceActive({
    required String serviceId,
    required bool isActive,
  });
}
