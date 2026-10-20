part of 'invite_worker_cubit.dart';

sealed class InviteWorkerState {
  const InviteWorkerState();
}

final class InviteWorkerInitial extends InviteWorkerState {
  const InviteWorkerInitial();
}

final class InviteWorkerSending extends InviteWorkerState {
  const InviteWorkerSending();
}

final class InviteWorkerSuccess extends InviteWorkerState {
  const InviteWorkerSuccess({required this.message});

  final String message;
}

final class InviteWorkerFailure extends InviteWorkerState {
  const InviteWorkerFailure({required this.message});

  final String message;
}
