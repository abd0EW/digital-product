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

  void initializeOriginalStatuses(List<ServiceModel> services) {
    _originalStatuses
      ..clear()
      ..addEntries(services.map((service) => MapEntry(service.id, service.isActive)));

    _changedServices.removeWhere(
      (id, status) =>
          _originalStatuses.containsKey(id) && _originalStatuses[id] == status,
    );
    _savedServices.removeWhere(
      (id, status) =>
          _originalStatuses.containsKey(id) && _originalStatuses[id] == status,
    );
    _emitChanges();
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
    if (state is OwnerUpdateServicesSaving || _changedServices.isEmpty) return;

    final changes = Map<String, bool>.from(_changedServices);
    final successfullySavedServiceIds = <String>[];
    final failedServiceIds = <String>[];

    emit(
      OwnerUpdateServicesSaving(
        changedServices: Map.unmodifiable(_changedServices),
        savedServices: Map.unmodifiable(_savedServices),
      ),
    );

    for (final entry in changes.entries) {
      try {
        await _updateServiceStatusUseCase.upddateSerivesActive(
          serviceId: entry.key,
          isActive: entry.value,
        );

        if (isClosed) return;

        successfullySavedServiceIds.add(entry.key);
        _originalStatuses[entry.key] = entry.value;
        _savedServices[entry.key] = entry.value;
        if (_changedServices[entry.key] == entry.value) {
          _changedServices.remove(entry.key);
        }
      } on Exception {
        if (isClosed) return;
        failedServiceIds.add(entry.key);
      }
    }

    if (isClosed) return;

    final changedServices = Map<String, bool>.unmodifiable(_changedServices);
    if (failedServiceIds.isEmpty) {
      emit(
        OwnerUpdateServicesSuccess(
          changedServices: changedServices,
          savedServices: Map.unmodifiable(_savedServices),
          successfullySavedServiceIds: successfullySavedServiceIds,
        ),
      );
    } else {
      emit(
        OwnerUpdateServicesFailure(
          changedServices: changedServices,
          savedServices: Map.unmodifiable(_savedServices),
          failureMessage: 'تعذر حفظ بعض التعديلات. تحقق من الاتصال وحاول مرة أخرى.',
          failedServiceIds: failedServiceIds,
          successfullySavedServiceIds: successfullySavedServiceIds,
        ),
      );
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
