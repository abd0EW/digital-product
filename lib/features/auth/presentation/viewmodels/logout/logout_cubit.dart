import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/logout/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({required this.repository}) : super(const LogoutInitial());

  final AuthRepository repository;

  Future<void> logout() async {
    emit(const LogoutLoading());

    final result = await repository.logout();
    if (isClosed) return;

    result.fold(_emitFailure, (_) => emit(const LogoutSuccess()));
  }

  void _emitFailure(AppFail failure) {
    emit(LogoutFailure(message: AuthErrorMessageHandler.getMessage(failure)));
  }
}
