part of 'assign_order_worker_cubit.dart';

sealed class AssignOrderWorkerState {
  const AssignOrderWorkerState();
}

final class AssignOrderWorkerInitial extends AssignOrderWorkerState {
  const AssignOrderWorkerInitial();
}

final class AssignOrderWorkerLoading extends AssignOrderWorkerState {
  const AssignOrderWorkerLoading();
}

final class AssignOrderWorkerSuccess extends AssignOrderWorkerState {
  const AssignOrderWorkerSuccess(this.worker);

  final WorkerInvitationModel worker;
}

final class AssignOrderWorkerFailure extends AssignOrderWorkerState {
  const AssignOrderWorkerFailure(this.message);

  final String message;
}
