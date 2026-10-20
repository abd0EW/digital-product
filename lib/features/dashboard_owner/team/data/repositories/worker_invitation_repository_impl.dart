import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_owner/team/data/data_remote_datasource/worker_invitation_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/failures/worker_invitation_failure.dart';
import 'package:digital_product/features/dashboard_owner/team/domain/repositories/worker_invitation_repository.dart';
import 'package:flutter/foundation.dart';
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
      return Left(_failure(exception, WorkerInvitationOperation.load));
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
      print("--------------------------------------");
      print(exception);
      print("--------------------------------------");
      return Left(_failure(exception, WorkerInvitationOperation.invite));
    }
  }

  WorkerInvitationFailure _failure(
    Object exception,
    WorkerInvitationOperation operation,
  ) {
    final code = exception is PostgrestException ? exception.code : null;
    debugPrint(
      'Worker invitation ${operation.name} failed: '
      '${exception.runtimeType}${code == null ? '' : ' (code: $code)'}',
    );
    return WorkerInvitationFailure(
      operation: operation,
      exception: exception,
      code: code,
    );
  }
}
