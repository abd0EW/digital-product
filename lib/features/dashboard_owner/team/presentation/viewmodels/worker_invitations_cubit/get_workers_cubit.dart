import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/usecases/get_worker_invitations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_workers_state.dart';

class GetWorkersCubit extends Cubit<GetWorkersState> {
  GetWorkersCubit(this._getWorkerInvitationsUseCase)
    : super(const GetWorkersStateInitial());

  final GetWorkerInvitationsUseCase _getWorkerInvitationsUseCase;
  int _loadRequestId = 0;

  Future<void> loadWorkerInvitations() async {
    if (isClosed) return;

    final requestId = ++_loadRequestId;

    emit(const GetWorkersStateLoading());

    final result = await _getWorkerInvitationsUseCase();

    if (isClosed || requestId != _loadRequestId) return;

    result.fold(
      (failure) {
        print("=================");
        print(failure);
        print("=================");
        emit(GetWorkersStateFailure(message: failure.userMessage));
      },
      (invitations) => emit(
        GetWorkersStateSuccess(invitations: List.unmodifiable(invitations)),
      ),
    );
  }
}
