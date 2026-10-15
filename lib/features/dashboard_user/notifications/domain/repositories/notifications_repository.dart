import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/failures/notification_failure.dart';

abstract interface class NotificationsRepository {
  Future<Either<NotificationFailure, List<NotificationModel>>>
  getNotifications();

  // Future<Either<NotificationFailure, void>> markAsRead({
  //   required String notificationId,
  // });
}
