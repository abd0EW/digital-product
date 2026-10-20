abstract class AuthPasswordRemoteDataSource {
  Future<void> updatePassword(String newPassword);
  Future<void> resetPassword(String email);
}
