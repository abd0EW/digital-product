import 'package:digital_product/features/auth/domain/enums/user_role.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<void> resendVerificationEmail(String email);

  Future<bool> checkEmailVerification();
}
