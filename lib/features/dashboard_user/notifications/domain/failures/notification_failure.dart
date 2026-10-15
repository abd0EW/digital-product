import 'package:digital_product/core/errors/app_fail.dart';

enum NotificationFailureOperation { load, update, realtime, order }

class NotificationFailure extends AppFail {
  const NotificationFailure({
    required this.operation,
    required this.exception,
    this.unauthenticated = false,
  }) : super(message: 'Notification operation failed');

  final NotificationFailureOperation operation;
  final Object exception;
  final bool unauthenticated;

  String get userMessage {
    if (unauthenticated) return 'سجّل دخولك لعرض إشعاراتك.';

    return switch (operation) {
      NotificationFailureOperation.load =>
        'ما قدرنا نحمّل الإشعارات حاليًا، حاول مرة ثانية.',
      NotificationFailureOperation.update =>
        'تعذر تحديث الإشعار، حاول مرة أخرى.',
      NotificationFailureOperation.realtime =>
        'انقطع الاتصال بالتحديثات المباشرة. نحاول إعادة الاتصال.',
      NotificationFailureOperation.order =>
        'الطلب المرتبط بهذا الإشعار غير متاح حاليًا.',
    };
  }
}
