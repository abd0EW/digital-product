sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required this.email, required this.userRole});

  final String email;
  final String userRole;
}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({required this.message});

  final String message;
}
