import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository}) : super(const RegisterInitial());

  final AuthRepository repository;

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    emit(const RegisterLoading());

    final result = await repository.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );

    if (isClosed) return;

    result.fold(
      _emitFailure,
      (_) => emit(RegisterSuccess(email: email, userRole: role.value)),
    );
  }

  void _emitFailure(AppFail failure) {
    emit(RegisterFailure(message: AuthErrorMessageHandler.getMessage(failure)));
  }
}
