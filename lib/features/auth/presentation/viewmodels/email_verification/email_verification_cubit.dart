import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/email_verification/email_verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit({required this.repository})
    : super(const EmailVerificationInitial());

  final AuthRepository repository;

  Future<void> resendVerificationEmail({required String email}) async {
    emit(const EmailVerificationLoading());

    final result = await repository.resendVerificationEmail(email: email);
    if (isClosed) return;

    result.fold(_emitFailure, (_) => emit(const EmailVerificationEmailSent()));
  }

  Future<bool?> checkEmailVerification() async {
    final result = await repository.checkEmailVerification();
    if (isClosed) return null;

    return result.fold(
      (failure) {
        _emitFailure(failure);
        return null;
      },
      (isVerified) {
        emit(EmailVerificationStatus(isVerified: isVerified));
        return isVerified;
      },
    );
  }

  void _emitFailure(AppFail failure) {
    emit(
      EmailVerificationFailure(
        message: AuthErrorMessageHandler.getMessage(failure),
      ),
    );
  }
}
