import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/data/data_remote_datasource/worker_invitation_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_Invitation_failure.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/repositories/worker_invitation_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkerInvitationRepositoryImpl implements WorkerInvitationRepository {
  const WorkerInvitationRepositoryImpl(this._remoteDataSource);

  final WorkerInvitationRemoteDataSource _remoteDataSource;

  @override
  Future<Either<WorkerInvitationFailure, List<WorkerInvitationModel>>>
  getWorkerInvitations() async {
    try {
      return Right(await _remoteDataSource.getWorkerInvitations());
    } catch (exception) {
      return Left(_failure(exception));
    }
  }

  @override
  Future<Either<WorkerInvitationFailure, Unit>> inviteWorker({
    required String fullName,
    required String email,
  }) async {
    try {
      await _remoteDataSource.inviteWorker(fullName: fullName, email: email);
      return const Right(unit);
    } catch (exception) {
      return Left(_failure(exception));
    }
  }

  @override
  Future<Either<WorkerInvitationFailure, Unit>> confirmWorkerAccount() async {
    try {
      await _remoteDataSource.confirmWorkerAccount();
      return const Right(unit);
    } catch (exception) {
      return Left(_failure(exception));
    }
  }

  WorkerInvitationFailure _failure(Object exception) {
    if (exception is FunctionsHttpException) {
      final details = exception.details;

      String message = 'Worker invitation operation failed';

      if (details is Map) {
        final error = details['error'];

        if (error != null) {
          message = error.toString();
        }
      }

      return WorkerInvitationFailure(
        message: message,
        code: exception.status.toString(),
      );
    }

    if (exception is PostgrestException) {
      return WorkerInvitationFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    return WorkerInvitationFailure(message: exception.toString());
  }
}
