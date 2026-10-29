abstract class AuthPasswordRemoteDataSource {
  Future<void> updatePassword(String newPassword);
  Future<void> setInvitedWorkerPassword({required String password});
  Future<void> resetPassword(String email);
}
