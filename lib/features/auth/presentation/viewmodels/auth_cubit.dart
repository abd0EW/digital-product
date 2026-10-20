import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/failures/auth_fail.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';

import 'package:digital_product/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.repository}) : super(const AuthInitial());

  final AuthRepository repository;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());

    try {
      final result = await repository.login(email: email, password: password);
      if (isClosed) return;
      result.fold(
        (failure) => _emitFailure(failure),
        (_) => emit(const AuthLoginSuccess()),
      );
    } catch (e) {
      if (isClosed) return;
      _emitFailure(AuthFail(message: e.toString()));
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    emit(const AuthLoading());

    final result = await repository.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );

    if (isClosed) return;

    result.fold(
      (exception) => _emitFailure(exception),
      (_) =>
          emit(AuthRegistrationSuccess(email: email, acountType: role.value)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await repository.logout();

    if (isClosed) return;

    result.fold(
      (exception) => _emitFailure(exception),
      (_) => emit(const AuthLoggedOut()),
    );
  }

  Future<UserRole> getCurrentUserRole() async {
    final result = await repository.getUserRole();

    return result.fold(
      (exception) {
        _emitFailure(exception);
        throw exception;
      },
      (role) {
        emit(AuthAuthenticated(role: role));
        return role;
      },
    );
  }

  Future<void> forgotPassword({
    required String email,
    required VoidCallback onRecovery,
  }) async {
    emit(const AuthLoading());

    final result = await repository.forgotPassword(email: email);

    if (isClosed) return;

    result.fold((exception) => _emitFailure(exception), (_) {
      emit(const AuthPasswordResetEmailSent());
    });
  }

  Future<void> resendVerificationEmail({required String email}) async {
    emit(const AuthLoading());

    final result = await repository.resendVerificationEmail(email: email);

    if (isClosed) return;

    result.fold(
      (exception) => _emitFailure(exception),
      (_) => emit(const AuthVerificationEmailSent()),
    );
  }

  Future<bool?> checkEmailVerification() async {
    final result = await repository.checkEmailVerification();

    if (isClosed) return null;

    return result.fold(
      (exception) {
        _emitFailure(exception);
        return;
      },

      (isVerified) {
        emit(AuthVerificationStatus(isVerified: isVerified));

        return isVerified;
      },
    );
  }

  Future<void> updatePassword({required String newPassword}) async {
    emit(const AuthLoading());

    final result = await repository.updatePassword(newPassword: newPassword);
    if (isClosed) return;

    result.fold((exception) => _emitFailure(exception), (_) {
      emit(const AuthUpdatedPassword());
    });
  }

  void _emitFailure(AppFail exception) {
    emit(AuthFailure(message: AuthErrorMessageHandler.getMessage(exception)));
  }
}
