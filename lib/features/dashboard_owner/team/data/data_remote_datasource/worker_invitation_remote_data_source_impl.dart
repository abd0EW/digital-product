import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/dashboard_owner/team/data/data_remote_datasource/worker_invitation_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkerInvitationRemoteDataSourceImpl
    implements WorkerInvitationRemoteDataSource {
  WorkerInvitationRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<List<WorkerInvitationModel>> getWorkerInvitations() async {
    final ownerProfileId = await _currentOwnerProfileId;
    final response = await _client
        .from('worker_invitations')
        .select()
        .eq('invited_by', ownerProfileId)
        .eq("status", "accepted")
        .order('created_at', ascending: false)
        .select();

    return response.map((row) => WorkerInvitationModel.fromJson(row)).toList();
  }

  @override
  Future<void> inviteWorker({
    required String fullName,
    required String email,
  }) async {
    await _client.functions.invoke(
      'invite-worker',
      body: {'full_name': fullName.trim(), 'email': email.trim()},
    );
  }

  Future<String> get _currentOwnerProfileId async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('User is not authenticated');
    }

    final profile = await _client
        .from('profiles')
        .select('id, role')
        .eq('id', user.id)
        .maybeSingle();

    if (profile == null || profile['role'] != UserRole.owner.value) {
      throw const AuthException('Current user is not an owner');
    }

    return profile['id'] as String;
  }

  @override
  Future<void> confirmWorkerAccount() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user found');
    }

    final email = user.email;

    if (email == null || email.isEmpty) {
      throw Exception('Authenticated user email not found');
    }

    await _client
        .from('worker_invitations')
        .update({'status': 'accepted', 'accepted_user_id': user.id})
        .eq('email', email)
        .eq('status', 'pending');
  }
}
