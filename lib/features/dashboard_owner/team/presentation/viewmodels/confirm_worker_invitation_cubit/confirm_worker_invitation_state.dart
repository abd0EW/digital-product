part of 'confirm_worker_invitation_cubit.dart';

sealed class ConfirmWorkerInvitationState {
  const ConfirmWorkerInvitationState();
}

final class ConfirmWorkerInvitationInitial
    extends ConfirmWorkerInvitationState {
  const ConfirmWorkerInvitationInitial();
}

final class ConfirmWorkerInvitationLoading
    extends ConfirmWorkerInvitationState {
  const ConfirmWorkerInvitationLoading();
}

final class ConfirmWorkerInvitationSuccess
    extends ConfirmWorkerInvitationState {
  const ConfirmWorkerInvitationSuccess();
}

final class ConfirmWorkerInvitationFailure
    extends ConfirmWorkerInvitationState {
  const ConfirmWorkerInvitationFailure({required this.message});

  final String message;
}
