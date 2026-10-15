part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notificationModel;
  NotificationSuccess({required this.notificationModel});
}

final class NotificationFailure extends NotificationState {
  final String messageFailure;
  NotificationFailure({required this.messageFailure});
}
