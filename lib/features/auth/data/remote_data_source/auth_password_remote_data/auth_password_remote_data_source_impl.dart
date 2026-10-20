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
