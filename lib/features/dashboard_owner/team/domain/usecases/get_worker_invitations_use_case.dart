import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_invitation_failure.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/repositories/worker_invitation_repository.dart';

class GetWorkerInvitationsUseCase {
  const GetWorkerInvitationsUseCase(this._repository);

  final WorkerInvitationRepository _repository;

  Future<Either<WorkerInvitationFailure, List<WorkerInvitationModel>>> call() {
    return _repository.getWorkerInvitations();
  }
}
