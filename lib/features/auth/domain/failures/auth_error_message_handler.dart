import 'package:digital_product/core/errors/app_fail.dart';

class AuthErrorMessageHandler {
  const AuthErrorMessageHandler._();

  static String getMessage(AppFail fail) {
    final message = fail.message.toLowerCase().trim();
    final code = fail.code?.toLowerCase().trim();

    switch (code) {
      case 'invalid_credentials':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

      case 'email_not_confirmed':
        return 'يرجى تأكيد البريد الإلكتروني أولًا.';

      case 'user_already_exists':
        return 'هذا البريد الإلكتروني مسجل بالفعل.';

      case 'weak_password':
        return 'كلمة المرور ضعيفة، اختر كلمة مرور أقوى.';

      case 'over_email_send_rate_limit':
        return 'تم إرسال محاولات كثيرة، حاول مرة أخرى لاحقًا.';
    }

    if (message.contains('invalid login credentials')) {
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
    }

    if (message.contains('email not confirmed')) {
      return 'يرجى تأكيد البريد الإلكتروني أولًا.';
    }

    if (message.contains('already registered') ||
        message.contains('user already exists')) {
      return 'هذا البريد الإلكتروني مسجل بالفعل.';
    }

    if (message.contains('rate limit')) {
      return 'تم إرسال محاولات كثيرة، حاول مرة أخرى لاحقًا.';
    }

    return 'حدث خطأ غير متوقع، حاول مرة أخرى.$message';
  }
}
