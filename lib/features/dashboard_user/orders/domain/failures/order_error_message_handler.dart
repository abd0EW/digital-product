import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';

class OrderErrorMessageHandler {
  const OrderErrorMessageHandler._();

  static String getMessage({required OrderFailure exception}) {
    if (exception is UnauthorizedOrderFailure) {
      return 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.';
    }

    if (exception is CreateOrderFail) {
      return 'تحقق من اتصال الإنترنت وحاول مرة أخرى.';
    }

    if (exception is CreateOrderFail) {
      return 'حجم الملف أكبر من الحد المسموح.';
    }

    if (exception is CreateOrderFail) {
      return 'نوع الملف غير مدعوم.';
    }

    if (exception is UploadFileFailure) {
      return 'تعذر رفع الملف. حاول مرة أخرى.';
    }

    if (exception is CreateOrderFail) {
      return 'تعذر إنشاء الطلب. حاول مرة أخرى.';
    }

    return 'حدث خطأ غير متوقع. حاول مرة أخرى.';
  }
}
