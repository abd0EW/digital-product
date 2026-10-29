import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/failures/auth_fail.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repository}) : super(const LoginInitial());

  final AuthRepository repository;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());

    try {
      final result = await repository.login(email: email, password: password);
      if (isClosed) return;

      result.fold(
        (failure) => _emitFailure(failure),
        (_) => emit(const LoginSuccess()),
      );
    } catch (error) {
      if (isClosed) return;
      _emitFailure(AuthFail(message: error.toString()));
    }
  }

  void _emitFailure(AppFail failure) {
    emit(LoginFailure(message: AuthErrorMessageHandler.getMessage(failure)));
  }
}
