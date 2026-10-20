import 'package:digital_product/features/auth/data/remote_data_source/auth_email_remote_data/auth_email_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/failures/auth_fail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthEmailRemoteDataSourceImpl implements AuthEmailRemoteDataSource {
  AuthEmailRemoteDataSourceImpl({required this._client});
  final SupabaseClient _client;

  Future<T> _handleAuthRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on AuthApiException catch (e) {
      throw AuthFail(message: e.message, code: e.code);
    } catch (e) {
      throw AuthFail(message: e.toString());
    }
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
}
