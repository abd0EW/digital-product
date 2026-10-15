import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/failures/notification_failure.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<NotificationFailure, List<NotificationModel>>> call() {
    return _repository.getNotifications();
  }
}
