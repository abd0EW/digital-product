import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_Invitation_failure.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/repositories/worker_invitation_repository.dart';

class ConfirmWorkerInvitationUseCase {
  ConfirmWorkerInvitationUseCase({required this.workerInvitationRepository});
  WorkerInvitationRepository workerInvitationRepository;

  Future<Either<WorkerInvitationFailure, Unit>> confirmWorker() async {
    return await workerInvitationRepository.confirmWorkerAccount();
  }
}
