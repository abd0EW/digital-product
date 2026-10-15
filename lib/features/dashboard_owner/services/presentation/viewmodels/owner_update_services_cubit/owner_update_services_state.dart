part of 'owner_update_services_cubit.dart';

sealed class OwnerUpdateServicesState {
  const OwnerUpdateServicesState({
    this.changedServices = const {},
    this.savedServices = const {},
  });

  final Map<String, bool> changedServices;
  final Map<String, bool> savedServices;
}

final class OwnerUpdateServicesInitial extends OwnerUpdateServicesState {
  const OwnerUpdateServicesInitial({super.savedServices});
}

final class OwnerUpdateServicesChanged extends OwnerUpdateServicesState {
  const OwnerUpdateServicesChanged({
    required super.changedServices,
    required super.savedServices,
  });
}

final class OwnerUpdateServicesSaving extends OwnerUpdateServicesState {
  const OwnerUpdateServicesSaving({
    required super.changedServices,
    required super.savedServices,
  });
}

final class OwnerUpdateServicesSuccess extends OwnerUpdateServicesState {
  const OwnerUpdateServicesSuccess({
    required super.changedServices,
    required super.savedServices,
    required this.successfullySavedServiceIds,
  });

  final List<String> successfullySavedServiceIds;
}

final class OwnerUpdateServicesFailure extends OwnerUpdateServicesState {
  const OwnerUpdateServicesFailure({
    required super.changedServices,
    required super.savedServices,
    required this.failureMessage,
    required this.failedServiceIds,
    required this.successfullySavedServiceIds,
  });

  final String failureMessage;
  final List<String> failedServiceIds;
  final List<String> successfullySavedServiceIds;
}
