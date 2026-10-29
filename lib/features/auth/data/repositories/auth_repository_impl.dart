import 'package:dartz/dartz.dart';
import 'package:digital_product/core/errors/app_fail.dart';
import 'package:digital_product/features/auth/data/remote_data_source/auth_email_remote_data/auth_email_remote_data_source.dart';
import 'package:digital_product/features/auth/data/remote_data_source/auth_password_remote_data/auth_password_remote_data_source.dart';
import 'package:digital_product/features/auth/data/remote_data_source/auth_remote_data/auth_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this._authRemoteDataSource,
    required this._authEmailRemoteDataSource,
    required this._authPasswordRemoteDataSource,
  });

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthEmailRemoteDataSource _authEmailRemoteDataSource;
  final AuthPasswordRemoteDataSource _authPasswordRemoteDataSource;

  @override
  Future<Either<AppFail, Unit>> login({
    required String email,
    required String password,
  }) {
    return _handleAuthAction(
      () => _authRemoteDataSource.signIn(email: email, password: password),
    );
  }

  @override
  Future<Either<AppFail, Unit>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) {
    return _handleAuthAction(
      () => _authRemoteDataSource.signUp(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        role: role,
      ),
    );
  }

  @override
  Future<Either<AppFail, Unit>> logout() {
    return _handleAuthAction(_authRemoteDataSource.signOut);
  }

  @override
  Future<Either<AppFail, Unit>> forgotPassword({required String email}) {
    return _handleAuthAction(
      () => _authPasswordRemoteDataSource.resetPassword(email),
    );
  }

  @override
  Future<Either<AppFail, Unit>> resendVerificationEmail({
    required String email,
  }) {
    return _handleAuthAction(
      () => _authEmailRemoteDataSource.resendVerificationEmail(email),
    );
  }

  @override
  Future<Either<AppFail, bool>> checkEmailVerification() async {
    try {
      final isVerified = await _authEmailRemoteDataSource
          .checkEmailVerification();

      return Right(isVerified);
    } on AppFail catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AppFail, Unit>> updatePassword({
    required String newPassword,
  }) async {
    try {
      await _authPasswordRemoteDataSource.updatePassword(newPassword);
      return const Right(unit);
    } on AppFail catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AppFail, Unit>> setInvitedWorkerPassword({
    required String password,
  }) {
    return _handleAuthAction(
      () => _authPasswordRemoteDataSource.setInvitedWorkerPassword(
        password: password,
      ),
    );
  }

  @override
  Future<Either<AppFail, String?>> getVerifiedAuthenticatedUserEmail() async {
    try {
      return Right(
        await _authRemoteDataSource.getVerifiedAuthenticatedUserEmail(),
      );
    } on AppFail catch (exception) {
      return Left(exception);
    }
  }

  Future<Either<AppFail, Unit>> _handleAuthAction(
    Future<void> Function() action,
  ) async {
    try {
      await action();

      return const Right(unit);
    } on AppFail catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AppFail, UserRole?>> getUserRole() async {
    try {
      final UserRole? role = await _authRemoteDataSource.getUserRole();

      return Right(role);
    } on AppFail catch (exception) {
      return Left(exception);
    }
  }
}
