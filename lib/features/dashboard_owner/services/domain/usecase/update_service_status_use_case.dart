import '../repositories/owner_services_repo.dart';

class UpdateServiceStatusUseCase {
  final OwnerServicesRepo repository;

  UpdateServiceStatusUseCase(this.repository);

  Future<void> upddateSerivesActive({
    required String serviceId,
    required bool isActiveService,
  }) async {
    await repository.updateServiceActive(
      serviceId: serviceId,
      isActive: isActiveService,
    );
  }
}
