import '../repositories/owner_services_repo.dart';

class UpdateServiceStatusUseCase {
  final OwnerServicesRepo repository;

  UpdateServiceStatusUseCase(this.repository);

  Future<void> upddateSerivesActive({
    required String serviceId,
    required bool isActive,
  }) async {
    await repository.updateServiceActive(
      serviceId: serviceId,
      isActive: isActive,
    );
  }
}
