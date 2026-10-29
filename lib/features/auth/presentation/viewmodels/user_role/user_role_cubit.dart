import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/user_role/user_role_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  UserRoleCubit({required this.repository}) : super(const UserRoleInitial());

  final AuthRepository repository;

  Future<UserRole?> getCurrentUserRole() async {
    final result = await repository.getUserRole();
    if (isClosed) {
      return result.fold((failure) => throw failure, (role) => role);
    }

    return result.fold(
      (failure) {
        emit(
          UserRoleFailure(message: AuthErrorMessageHandler.getMessage(failure)),
        );
        throw failure;
      },
      (role) {
        emit(UserRoleLoaded(role: role));
        return role;
      },
    );
  }
}
