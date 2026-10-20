import 'package:digital_product/features/dashboard_owner/team/domain/usecases/invite_worker_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'invite_worker_state.dart';

class InviteWorkerCubit extends Cubit<InviteWorkerState> {
  InviteWorkerCubit(this._inviteWorkerUseCase)
    : super(const InviteWorkerInitial());

  final InviteWorkerUseCase _inviteWorkerUseCase;
  bool _isSending = false;

  Future<void> inviteWorker({
    required String fullName,
    required String email,
  }) async {
    if (isClosed || _isSending) return;

    _isSending = true;
    emit(const InviteWorkerSending());

    try {
      final result = await _inviteWorkerUseCase(
        fullName: fullName.trim(),
        email: email.trim(),
      );

      if (isClosed) return;

      result.fold(
        (failure) => emit(InviteWorkerFailure(message: failure.userMessage)),

        (_) =>
            emit(const InviteWorkerSuccess(message: 'تم إرسال الدعوة بنجاح.')),
      );
    } finally {
      _isSending = false;
    }
  }
}
