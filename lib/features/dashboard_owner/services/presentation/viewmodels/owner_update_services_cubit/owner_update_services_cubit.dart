import 'package:digital_product/features/dashboard_owner/services/domain/usecase/update_service_status_use_case.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'owner_update_services_state.dart';

class OwnerUpdateServicesCubit extends Cubit<OwnerUpdateServicesState> {
  OwnerUpdateServicesCubit(this._updateServiceStatusUseCase)
    : super(const OwnerUpdateServicesInitial());

  final UpdateServiceStatusUseCase _updateServiceStatusUseCase;
  final Map<String, bool> _originalStatuses = {};
  final Map<String, bool> _changedServices = {};
  final Map<String, bool> _savedServices = {};

  void initServices(List<ServiceModel> services) {
    _originalStatuses
      ..clear()
      ..addAll({for (final service in services) service.id: service.isActive});
  }

  void changeServiceStatus({required String id, required bool isActive}) {
    if (state is OwnerUpdateServicesSaving ||
        !_originalStatuses.containsKey(id)) {
      return;
    }

    if (_originalStatuses[id] == isActive) {
      _changedServices.remove(id);
    } else {
      _changedServices[id] = isActive;
    }

    _emitChanges();
  }

  Future<void> saveChanges() async {
    try {
      if (state is OwnerUpdateServicesSaving || _changedServices.isEmpty) {
        return;
      }

      final changes = Map<String, bool>.from(_changedServices);
      for (final entry in changes.entries) {
        await _updateServiceStatusUseCase.upddateSerivesActive(
          serviceId: entry.key,
          isActiveService: entry.value,
        );
        _originalStatuses[entry.key] = entry.value;
        _changedServices.remove(entry.key);
        _savedServices[entry.key] = entry.value;
      }
      if (isClosed) return;
      emit(
        OwnerUpdateServicesSaving(
          changedServices: changes,
          savedServices: Map.unmodifiable(_savedServices),
        ),
      );
    } catch (error) {
      emit(OwnerUpdateServicesFailure(failureMessage: error.toString()));
    }
  }

  void _emitChanges() {
    final changedServices = Map<String, bool>.unmodifiable(_changedServices);
    if (changedServices.isEmpty) {
      emit(
        OwnerUpdateServicesInitial(
          savedServices: Map.unmodifiable(_savedServices),
        ),
      );
    } else {
      emit(
        OwnerUpdateServicesChanged(
          changedServices: changedServices,
          savedServices: Map.unmodifiable(_savedServices),
        ),
      );
    }
  }
}
