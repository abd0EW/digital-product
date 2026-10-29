import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit({required this.repository}) : super(const PasswordInitial());

  final AuthRepository repository;

  Future<void> forgotPassword({required String email}) async {
    emit(const PasswordLoading());

    final result = await repository.forgotPassword(email: email);
    if (isClosed) return;

    result.fold(_emitFailure, (_) => emit(const PasswordResetEmailSent()));
  }

  Future<void> updatePassword({required String newPassword}) async {
    emit(const PasswordLoading());

    final result = await repository.updatePassword(newPassword: newPassword);
    if (isClosed) return;

    result.fold(_emitFailure, (_) => emit(const PasswordUpdated()));
  }

  Future<void> setInvitedWorkerPassword({required String password}) async {
    emit(const PasswordLoading());

    final result = await repository.setInvitedWorkerPassword(
      password: password,
    );
    if (isClosed) return;

    result.fold(
      _emitInvitedWorkerFailure,
      (_) => emit(const InvitedWorkerPasswordSet()),
    );
  }

  Future<String?> getVerifiedAuthenticatedUserEmail() async {
    final result = await repository.getVerifiedAuthenticatedUserEmail();
    if (isClosed) return null;

    return result.fold((failure) {
      _emitInvitedWorkerFailure(failure);
      return null;
    }, (email) => email);
  }

  void _emitInvitedWorkerFailure(AppFail failure) {
    emit(
      InvitedWorkerPasswordFailure(
        message: AuthErrorMessageHandler.getMessage(failure),
      ),
    );
  }

  void _emitFailure(AppFail failure) {
    emit(PasswordFailure(message: AuthErrorMessageHandler.getMessage(failure)));
  }
}
