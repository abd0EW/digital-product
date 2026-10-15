part of 'owner_get_services_cubit.dart';

@immutable
sealed class OwnerGetServicesState {}

final class OwnerGetServicesInitial extends OwnerGetServicesState {}

final class OwnerGetServicesLoading extends OwnerGetServicesState {
  final List<ServiceModel> serviceModel;

  OwnerGetServicesLoading({required this.serviceModel});
}

final class OwnerGetServicesSuccess extends OwnerGetServicesState {
  final List<ServiceModel> serviceModel;

  OwnerGetServicesSuccess({required this.serviceModel});
}

final class OwnerGetServicesFailure extends OwnerGetServicesState {
  final String failureMessage;
  final List<ServiceModel> serviceModel;

  OwnerGetServicesFailure({
    required this.failureMessage,
    required this.serviceModel,
  });
}
