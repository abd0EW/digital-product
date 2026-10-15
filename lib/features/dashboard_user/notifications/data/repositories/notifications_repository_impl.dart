import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/remote_data_source/notification_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/failures/notification_failure.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/repositories/notifications_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._notificationRemoteDataSource);

  final NotificationRemoteDataSource _notificationRemoteDataSource;

  @override
  Future<Either<NotificationFailure, List<NotificationModel>>>
  getNotifications() async {
    try {
      return Right(await _notificationRemoteDataSource.getNotifications());
    } catch (exception) {
      return Left(_failure(exception, NotificationFailureOperation.load));
    }
  }

  NotificationFailure _failure(
    Object exception,
    NotificationFailureOperation operation,
  ) {
    debugPrint(
      'Notifications ${operation.name} failed: ${exception.runtimeType}',
    );
    return NotificationFailure(
      operation: operation,
      exception: exception,
      unauthenticated: exception is AuthException,
    );
  }
}
