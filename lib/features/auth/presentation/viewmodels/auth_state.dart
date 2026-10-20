import 'package:digital_product/features/auth/domain/enums/user_role.dart';

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
  const AuthRegistrationSuccess({
    required this.email,
    required this.acountType,
  });
  final String acountType;
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

final class AuthUpdatedPassword extends AuthState {
  const AuthUpdatedPassword();
}

final class AuthAuthenticated extends AuthState {
  final UserRole role;
  const AuthAuthenticated({required this.role});
}

final class AuthVerificationStatus extends AuthState {
  const AuthVerificationStatus({required this.isVerified});

  final bool isVerified;
}

final class AuthFailure extends AuthState {
  const AuthFailure({required this.message});

  final String message;
}
