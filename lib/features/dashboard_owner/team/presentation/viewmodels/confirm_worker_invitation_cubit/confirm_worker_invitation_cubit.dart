import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_invitation_error_handler.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/usecases/confirm_worker_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_worker_invitation_state.dart';

class ConfirmWorkerInvitationCubit extends Cubit<ConfirmWorkerInvitationState> {
  ConfirmWorkerInvitationCubit(this._confirmWorkerInvitationUseCase)
    : super(const ConfirmWorkerInvitationInitial());

  final ConfirmWorkerInvitationUseCase _confirmWorkerInvitationUseCase;

  Future<void> confirmWorkerInvitation() async {
    if (isClosed) return;

    emit(const ConfirmWorkerInvitationLoading());

    final result = await _confirmWorkerInvitationUseCase.confirmWorker();

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ConfirmWorkerInvitationFailure(
          message: WorkerInvitationErrorHandler.handle(failure),
        ),
      ),
      (_) => emit(const ConfirmWorkerInvitationSuccess()),
    );
  }
}
