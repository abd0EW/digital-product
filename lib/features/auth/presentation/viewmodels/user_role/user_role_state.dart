import 'package:digital_product/features/auth/domain/enums/user_role.dart';

sealed class UserRoleState {
  const UserRoleState();
}

final class UserRoleInitial extends UserRoleState {
  const UserRoleInitial();
}

final class UserRoleLoaded extends UserRoleState {
  const UserRoleLoaded({required this.role});

  final UserRole? role;
}

final class UserRoleFailure extends UserRoleState {
  const UserRoleFailure({required this.message});

  final String message;
}
