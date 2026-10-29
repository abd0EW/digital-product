import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_Invitation_failure.dart';

abstract interface class WorkerInvitationRepository {
  Future<Either<WorkerInvitationFailure, List<WorkerInvitationModel>>>
  getWorkerInvitations();

  Future<Either<WorkerInvitationFailure, Unit>> inviteWorker({
    required String fullName,
    required String email,
  });

  Future<Either<WorkerInvitationFailure, Unit>> confirmWorkerAccount();
}
