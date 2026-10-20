import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';

abstract interface class WorkerInvitationRemoteDataSource {
  Future<List<WorkerInvitationModel>> getWorkerInvitations();

  Future<void> inviteWorker({required String fullName, required String email});
}
