import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import '../../../domain/failures/failure.dart';

sealed class ServicesState {
  const ServicesState();
}

final class ServicesInitial extends ServicesState {
  const ServicesInitial();
}

final class ServicesLoading extends ServicesState {
  const ServicesLoading();
}

final class ServicesSuccess extends ServicesState {
  final List<ServiceModel> general;
  final List<ServiceModel> educational;
  final int toggleIndex;

  const ServicesSuccess({
    required this.general,
    required this.educational,
    required this.toggleIndex,
  });

  ServicesSuccess copyWith({
    List<ServiceModel>? general,
    List<ServiceModel>? educational,
    int? toggleIndex,
  }) {
    return ServicesSuccess(
      general: general ?? this.general,
      educational: educational ?? this.educational,
      toggleIndex: toggleIndex ?? this.toggleIndex,
    );
  }
}

final class ServicesFailure extends ServicesState {
  final Failure failure;
  const ServicesFailure(this.failure);
}
