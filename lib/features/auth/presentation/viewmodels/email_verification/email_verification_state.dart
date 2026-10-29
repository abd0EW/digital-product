sealed class EmailVerificationState {
  const EmailVerificationState();
}

final class EmailVerificationInitial extends EmailVerificationState {
  const EmailVerificationInitial();
}

final class EmailVerificationLoading extends EmailVerificationState {
  const EmailVerificationLoading();
}

final class EmailVerificationEmailSent extends EmailVerificationState {
  const EmailVerificationEmailSent();
}

final class EmailVerificationStatus extends EmailVerificationState {
  const EmailVerificationStatus({required this.isVerified});

  final bool isVerified;
}

final class EmailVerificationFailure extends EmailVerificationState {
  const EmailVerificationFailure({required this.message});

  final String message;
}
