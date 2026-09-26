import 'package:dartz/dartz.dart';
import 'package:digital_product/core/errors/app_exception.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';

abstract interface class AuthRepository {
  Future<Either<AppException, Unit>> login({
    required String email,
    required String password,
  });

  Future<Either<AppException, Unit>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  Future<Either<AppException, Unit>> logout();

  Future<Either<AppException, Unit>> forgotPassword({required String email});

  Future<Either<AppException, Unit>> resendVerificationEmail({
    required String email,
  });

  Future<Either<AppException, bool>> checkEmailVerification();
}
