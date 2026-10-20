part of 'get_workers_cubit.dart';

sealed class GetWorkersState {
  const GetWorkersState();
}

final class GetWorkersStateInitial extends GetWorkersState {
  const GetWorkersStateInitial();
}

final class GetWorkersStateLoading extends GetWorkersState {
  const GetWorkersStateLoading();
}

final class GetWorkersStateSuccess extends GetWorkersState {
  const GetWorkersStateSuccess({required this.invitations});

  final List<WorkerInvitationModel> invitations;
}

final class GetWorkersStateFailure extends GetWorkersState {
  const GetWorkersStateFailure({required this.message});

  final String message;
}
