import 'package:digital_product/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/domain/failures/auth_fail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required SupabaseClient client}) : _client = client;

  final SupabaseClient _client;

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    await _handleAuthRequest(
      () => _client.auth.signUp(
        email: email.trim(),
        password: password,
        emailRedirectTo: 'http://localhost:50117/verify-email',
        data: {
          'full_name': fullName.trim(),
          'phone': phone.trim(),
          'role': role.value,
        },
      ),
    );
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _handleAuthRequest(
      () => _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  @override
  Future<void> signOut() async {
    await _handleAuthRequest(() => _client.auth.signOut());
  }

  @override
  Future<void> resetPassword(String email) async {
    await _handleAuthRequest(
      () => _client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: "http://localhost:50117/reset-password",
      ),
    );
    print("===================");
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    await _handleAuthRequest(
      () => _client.auth.resend(type: OtpType.signup, email: email.trim()),
    );
  }

  @override
  Future<bool> checkEmailVerification() async {
    try {
      final user = _client.auth.currentUser;

      return user?.emailConfirmedAt != null;
    } on AuthApiException catch (e) {
      throw AuthFail(message: e.message, code: e.code);
    } catch (e) {
      throw AuthFail(message: e.toString());
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _handleAuthRequest(
      () => _client.auth.updateUser(UserAttributes(password: newPassword)),
    );
  }

  Future<T> _handleAuthRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on AuthApiException catch (e) {
      throw AuthFail(message: e.message, code: e.code);
    } catch (e) {
      throw AuthFail(message: e.toString());
    }
  }
}
