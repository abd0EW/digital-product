import 'dart:async';
import 'dart:io';

import 'package:digital_product/core/errors/app_fail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum WorkerInvitationOperation { load, invite }

class WorkerInvitationFailure extends AppFail {
  const WorkerInvitationFailure({
    required this.operation,
    required this.exception,
    super.code,
  }) : super(message: 'Worker invitation operation failed');

  final WorkerInvitationOperation operation;
  final Object exception;

  bool get _isNetworkFailure =>
      exception is SocketException || exception is TimeoutException;

  bool get _isUnauthenticated => exception is AuthException;

  String get userMessage {
    if (_isNetworkFailure) {
      return 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى.';
    }
    if (_isUnauthenticated) {
      return 'يلزم تسجيل الدخول بحساب مالك لإدارة دعوات العمال.';
    }

    return switch (operation) {
      WorkerInvitationOperation.load =>
        'تعذّر تحميل قائمة العمال، حاول مرة أخرى.',
      WorkerInvitationOperation.invite when code == '23505' =>
        'توجد دعوة مسجلة لهذا البريد الإلكتروني بالفعل.',
      WorkerInvitationOperation.invite
          when code == '22P02' ||
              code == '23502' ||
              code == '23514' ||
              code == '22001' =>
        'تعذّر إرسال الدعوة، تأكد من البيانات وحاول مرة أخرى.',
      WorkerInvitationOperation.invite => 'تعذّر إرسال الدعوة، حاول مرة أخرى.',
    };
  }
}
