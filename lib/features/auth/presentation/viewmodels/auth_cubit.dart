import 'package:digital_product/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepositoryImpl authRepositoryImpl, {required this._repository})
    : super(const AuthInitial());

  final AuthRepository _repository;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());

    final result = await _repository.login(email: email, password: password);

    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const AuthLoginSuccess()),
    );
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    emit(const AuthLoading());

    final result = await _repository.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthRegistrationSuccess(email: email)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await _repository.logout();

    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const AuthLoggedOut()),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoading());

    final result = await _repository.forgotPassword(email: email);

    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const AuthPasswordResetEmailSent()),
    );
  }

  Future<void> resendVerificationEmail({required String email}) async {
    emit(const AuthLoading());

    final result = await _repository.resendVerificationEmail(email: email);

    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const AuthVerificationEmailSent()),
    );
  }

  Future<bool?> checkEmailVerification() async {
    final result = await _repository.checkEmailVerification();

    if (isClosed) return null;

    return result.fold(
      (failure) {
        emit(AuthFailure(message: failure.message));

        return null;
      },
      (isVerified) {
        emit(AuthVerificationStatus(isVerified: isVerified));

        return isVerified;
      },
    );
  }
}
