class NotificationTimeFormatter {
  NotificationTimeFormatter._();

  static String format(DateTime? date) {
    if (date == null) return 'الآن';

    final difference = DateTime.now().difference(date.toLocal());
    if (difference.isNegative || difference.inMinutes < 1) return 'الآن';
    if (difference.inHours < 1) {
      return 'منذ ${_arabicDigits(difference.inMinutes)} دقيقة';
    }
    if (difference.inHours < 24) {
      return 'منذ ${_arabicDigits(difference.inHours)} ساعة';
    }
    if (difference.inDays == 1) return 'أمس';
    if (difference.inDays < 7) {
      return 'منذ ${_arabicDigits(difference.inDays)} أيام';
    }

    final localDate = date.toLocal();
    return '${_arabicDigits(localDate.day)}'
        '/${_arabicDigits(localDate.month)}'
        '/${_arabicDigits(localDate.year)}';
  }

  static String _arabicDigits(int value) {
    return value.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      final digit = int.parse(match.group(0)!);
      return String.fromCharCode(0x0660 + digit);
    });
  }
}
