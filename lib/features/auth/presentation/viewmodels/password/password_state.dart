sealed class PasswordState {
  const PasswordState();
}

final class PasswordInitial extends PasswordState {
  const PasswordInitial();
}

final class PasswordLoading extends PasswordState {
  const PasswordLoading();
}

final class PasswordResetEmailSent extends PasswordState {
  const PasswordResetEmailSent();
}

final class PasswordUpdated extends PasswordState {
  const PasswordUpdated();
}

final class InvitedWorkerPasswordSet extends PasswordState {
  const InvitedWorkerPasswordSet();
}

final class InvitedWorkerPasswordFailure extends PasswordState {
  const InvitedWorkerPasswordFailure({required this.message});

  final String message;
}

final class PasswordFailure extends PasswordState {
  const PasswordFailure({required this.message});

  final String message;
}
