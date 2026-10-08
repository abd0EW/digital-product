import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<ProfileModel> getProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('User is not authenticated');
    }

    final profile = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();
    print("00000000000000000000000");
    print(profile);
    return ProfileModel.fromJson(profile);
  }

  @override
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
