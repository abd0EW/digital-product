import 'package:dartz/dartz.dart';
import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';

abstract interface class AuthRepository {
  Future<Either<AppFail, Unit>> login({
    required String email,
    required String password,
  });

  Future<Either<AppFail, Unit>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  Future<Either<AppFail, Unit>> logout();

  Future<Either<AppFail, Unit>> forgotPassword({required String email});

  Future<Either<AppFail, Unit>> resendVerificationEmail({
    required String email,
  });

  Future<Either<AppFail, Unit>> updatePassword({required String newPassword});
  Future<Either<AppFail, bool>> checkEmailVerification();
}
