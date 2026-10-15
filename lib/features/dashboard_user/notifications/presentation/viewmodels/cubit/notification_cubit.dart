import 'package:bloc/bloc.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this._getNotificationsUseCase})
    : super(NotificationInitial());
  List<NotificationModel> notifications = [];
  final GetNotificationsUseCase _getNotificationsUseCase;

  Future<void> getNotification() async {
    if (isClosed) return;

    emit(NotificationLoading());

    try {
      final result = await _getNotificationsUseCase();

      if (isClosed) return;

      result.fold(
        (failure) {
          emit(NotificationFailure(messageFailure: failure.toString()));
        },
        (notificationModels) {
          notifications = notificationModels;

          emit(NotificationSuccess(notificationModel: notificationModels));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(NotificationFailure(messageFailure: e.toString()));
    }
  }
}
