import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/domain/repositories/services_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository _servicesRepository;

  ServicesCubit(this._servicesRepository) : super(const ServicesInitial());

  List<ServiceModel> _allServices = [];

  Future<void> getServices() async {
    emit(const ServicesLoading());

    final result = await _servicesRepository.getServices();

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(ServicesFailure(failure));
      },
      (services) {
        _allServices = List.unmodifiable(services);

        _emitServices(_allServices);
      },
    );
  }

  void changeToggle(int index) {
    final currentState = state;

    if (currentState is! ServicesSuccess) return;

    if (currentState.toggleIndex == index) return;

    emit(currentState.copyWith(toggleIndex: index));
  }

  void onSearchChanged(String query) {
    if (state is! ServicesSuccess) return;

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      _emitServices(_allServices);
      return;
    }

    final filteredServices = _allServices.where((service) {
      return service.nameAr.toLowerCase().contains(normalizedQuery);
    }).toList();

    _emitServices(filteredServices);
  }

  void _emitServices(List<ServiceModel> services) {
    final educational = services
        .where((service) => service.category == 'educational')
        .toList();

    final general = services
        .where((service) => service.category == 'general')
        .toList();

    emit(
      ServicesSuccess(
        general: general,
        educational: educational,
        toggleIndex: _currentToggleIndex,
      ),
    );
  }

  int get _currentToggleIndex {
    final currentState = state;

    if (currentState is ServicesSuccess) {
      return currentState.toggleIndex;
    }

    return 0;
  }
}
