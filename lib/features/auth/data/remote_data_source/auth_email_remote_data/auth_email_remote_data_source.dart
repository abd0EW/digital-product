abstract interface class AuthEmailRemoteDataSource {
  Future<void> resendVerificationEmail(String email);

  Future<bool> checkEmailVerification();
}
