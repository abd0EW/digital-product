import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_Invitation_failure.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/repositories/worker_invitation_repository.dart';

class InviteWorkerUseCase {
  const InviteWorkerUseCase(this._repository);

  final WorkerInvitationRepository _repository;

  Future<Either<WorkerInvitationFailure, Unit>> call({
    required String fullName,
    required String email,
  }) {
    return _repository.inviteWorker(fullName: fullName, email: email);
  }
}
