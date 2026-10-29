import 'package:digital_product/features/auth/data/remote_data_source/auth_password_remote_data/auth_password_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/failures/auth_fail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPasswordRemoteDataSourceImpl implements AuthPasswordRemoteDataSource {
  AuthPasswordRemoteDataSourceImpl({required SupabaseClient client})
    : _client = client;
  final SupabaseClient _client;

  @override
  Future<void> resetPassword(String email) async {
    await _handleAuthRequest(
      () => _client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: "http://localhost:50117/reset-password",
      ),
    );
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _handleAuthRequest(
      () => _client.auth.updateUser(UserAttributes(password: newPassword)),
    );
  }

  @override
  Future<void> setInvitedWorkerPassword({required String password}) async {
    final session = _client.auth.currentSession;
    final user = _client.auth.currentUser;
    if (session == null ||
        user == null ||
        user.id != session.user.id ||
        session.expiresAt == null ||
        session.isExpired ||
        session.accessToken.trim().isEmpty) {
      throw const AuthFail(
        message: 'A valid authenticated session is required to set a password.',
        code: 'session_not_found',
      );
    }

    await _handleAuthRequest(
      () => _client.auth.updateUser(UserAttributes(password: password)),
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
