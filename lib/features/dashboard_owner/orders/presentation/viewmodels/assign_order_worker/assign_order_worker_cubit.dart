import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assign_order_worker_state.dart';

class AssignOrderWorkerCubit extends Cubit<AssignOrderWorkerState> {
  AssignOrderWorkerCubit(this._getOrdersUsecase)
    : super(const AssignOrderWorkerInitial());

  final GetOrdersUsecase _getOrdersUsecase;

  Future<void> assignWorker({
    required String orderId,
    required WorkerInvitationModel worker,
  }) async {
    if (state is AssignOrderWorkerLoading) return;

    final workerId = worker.acceptedUserId;
    if (workerId == null || workerId.trim().isEmpty) {
      emit(
        const AssignOrderWorkerFailure(
          'تعذر تحديد حساب العامل. يرجى تحديث قائمة العمال.',
        ),
      );
      return;
    }

    emit(const AssignOrderWorkerLoading());
    final result = await _getOrdersUsecase.assignWorker(
      orderId: orderId,
      workerId: workerId,
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        AssignOrderWorkerFailure(_messageFor(failure)),
      ),
      (_) => emit(AssignOrderWorkerSuccess(worker)),
    );
  }

  String _messageFor(OrderFailure failure) {
    if (failure is AssignWorkerFailure) {
      return 'تعذر تعيين العامل لهذا الطلب. تأكد من صلاحية الطلب وحاول مرة أخرى.';
    }

    return 'تعذر تعيين العامل. حاول مرة أخرى.';
  }
}
