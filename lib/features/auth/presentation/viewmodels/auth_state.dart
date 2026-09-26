sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess();
}

final class AuthRegistrationSuccess extends AuthState {
  const AuthRegistrationSuccess({required this.email});

  final String email;
}

final class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

final class AuthPasswordResetEmailSent extends AuthState {
  const AuthPasswordResetEmailSent();
}

final class AuthVerificationEmailSent extends AuthState {
  const AuthVerificationEmailSent();
}

final class AuthVerificationStatus extends AuthState {
  const AuthVerificationStatus({required this.isVerified});

  final bool isVerified;
}

final class AuthFailure extends AuthState {
  const AuthFailure({required this.message});

  final String message;
}
