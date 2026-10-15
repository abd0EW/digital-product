import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

class OrderDisplayFormatter {
  OrderDisplayFormatter._();

  static const List<String> _monthNames = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  static String statusLabel(String status) {
    return switch (status.trim().toLowerCase()) {
      'pending' => 'بانتظار الدفع',
      'in_progress' => 'قيد التنفيذ',
      'completed' => 'مكتمل',
      'rejected' => 'مرفوض',
      'cancelled' || 'canceled' => 'ملغي',
      _ => 'غير محدد',
    };
  }

  static String paymentStatusLabel(String status) {
    return switch (status.trim().toLowerCase()) {
      'pending' || 'awaiting_payment' || 'unpaid' => 'بانتظار الدفع',
      'paid' || 'completed' => 'مدفوع',
      'failed' => 'تعذر الدفع',
      'refunded' => 'مسترد',
      _ => 'غير محدد',
    };
  }

  static String paymentTimingLabel(String timing) {
    return switch (timing.trim().toLowerCase().replaceAll('-', '_')) {
      'before' || 'before_completion' => 'الدفع قبل الإنجاز',
      'after' || 'after_completion' => 'الدفع بعد الإنجاز',
      _ => 'غير محدد',
    };
  }

  static bool isPaymentDue(OrderModel order) {
    final paymentStatus = order.paymentStatus.trim().toLowerCase();
    final paymentTiming = order.paymentTiming.trim().toLowerCase().replaceAll(
      '-',
      '_',
    );

    return order.status.trim().toLowerCase() == 'pending' &&
        (paymentStatus == 'pending' ||
            paymentStatus == 'awaiting_payment' ||
            paymentStatus == 'unpaid') &&
        (paymentTiming == 'before' || paymentTiming == 'before_completion');
  }

  static String? date(DateTime? value) {
    if (value == null) return null;

    final localDate = value.toLocal();
    final formatted =
        '${localDate.day} ${_monthNames[localDate.month - 1]} ${localDate.year}';
    return _arabicDigits(formatted);
  }

  static String price(double value) {
    var formatted = value.toStringAsFixed(2);
    if (formatted.endsWith('.00')) {
      formatted = formatted.substring(0, formatted.length - 3);
    } else if (formatted.endsWith('0')) {
      formatted = formatted.substring(0, formatted.length - 1);
    }

    return _arabicDigits(formatted);
  }

  static String _arabicDigits(String value) {
    return value.replaceAllMapped(RegExp(r'\d'), (match) {
      final digit = int.parse(match.group(0)!);
      return String.fromCharCode(0x0660 + digit);
    });
  }
}
