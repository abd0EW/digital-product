import 'package:digital_product/features/dashboard_owner/services/domain/usecase/get_services__owner_use_case.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'owner_get_services_state.dart';

class OwnerGetServicesCubit extends Cubit<OwnerGetServicesState> {
  OwnerGetServicesCubit(this._getServicesUseCase)
    : super(OwnerGetServicesInitial());

  final GetServicesOwnerUseCase _getServicesUseCase;
  List<ServiceModel> _services = const [];
  int _requestId = 0;

  Future<void> getServices() async {
    final requestId = ++_requestId;
    emit(OwnerGetServicesLoading(serviceModel: _services));

    final response = await _getServicesUseCase.getServices();

    if (isClosed || requestId != _requestId) return;

    response.fold(
      (failure) {
        print("==========================");
        print(failure);
        emit(
          OwnerGetServicesFailure(
            failureMessage: failure.toString(),
            serviceModel: _services,
          ),
        );
      },
      (services) {
        _services = List.unmodifiable(services);
        emit(OwnerGetServicesSuccess(serviceModel: _services));
      },
    );
  }
}
