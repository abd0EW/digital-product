import 'package:dartz/dartz.dart';
import 'package:digital_product/core/errors/app_exception.dart';
import 'package:digital_product/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/failures/auth_error_message_handler.dart';
import 'package:digital_product/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this._authRemoteDataSource});

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Either<AppException, Unit>> login({
    required String email,
    required String password,
  }) {
    return _handleAuthAction(
      () => _authRemoteDataSource.signIn(email: email, password: password),
    );
  }

  @override
  Future<Either<AppException, Unit>> register({
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
  Future<Either<AppException, Unit>> logout() {
    return _handleAuthAction(_authRemoteDataSource.signOut);
  }

  @override
  Future<Either<AppException, Unit>> forgotPassword({required String email}) {
    return _handleAuthAction(() => _authRemoteDataSource.resetPassword(email));
  }

  @override
  Future<Either<AppException, Unit>> resendVerificationEmail({
    required String email,
  }) {
    return _handleAuthAction(
      () => _authRemoteDataSource.resendVerificationEmail(email),
    );
  }

  @override
  Future<Either<AppException, bool>> checkEmailVerification() async {
    try {
      final isVerified = await _authRemoteDataSource.checkEmailVerification();

      return Right(isVerified);
    } on AppException catch (exception) {
      return Left(
        AuthErrorMessageHandler.getMessage(exception) as AppException,
      );
    }
  }

  Future<Either<AppException, Unit>> _handleAuthAction(
    Future<void> Function() action,
  ) async {
    try {
      await action();

      return const Right(unit);
    } on AppException catch (exception) {
      return Left(
        AuthErrorMessageHandler.getMessage(exception) as AppException,
      );
    }
  }
}
