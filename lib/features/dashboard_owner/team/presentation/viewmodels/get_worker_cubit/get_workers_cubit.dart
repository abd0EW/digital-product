import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_invitation_error_handler.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/usecases/get_worker_invitations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_workers_state.dart';

class GetWorkersCubit extends Cubit<GetWorkersState> {
  GetWorkersCubit(this._getWorkerInvitationsUseCase)
    : super(const GetWorkersStateInitial());

  final GetWorkerInvitationsUseCase _getWorkerInvitationsUseCase;

  Future<void> getWorkers() async {
    if (isClosed) return;

    emit(const GetWorkersStateLoading());

    final result = await _getWorkerInvitationsUseCase();

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          GetWorkersStateFailure(
            message: WorkerInvitationErrorHandler.handle(failure),
          ),
        );
      },
      (invitations) {
        print("============invitations=====================");

        emit(
          GetWorkersStateSuccess(invitations: List.unmodifiable(invitations)),
        );
        print(invitations);
        print("============invitationsEnd=====================");
      },
    );
  }
}
