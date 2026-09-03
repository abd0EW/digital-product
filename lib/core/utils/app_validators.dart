class AppValidators {
  AppValidators._();

  static String? requiredField(
    String? value, {
    String fieldName = 'هذا الحقل',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال $fieldName';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, fieldName: 'البريد الإلكتروني');
    if (requiredError != null) return requiredError;

    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(value!.trim())) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = requiredField(value, fieldName: 'كلمة المرور');
    if (requiredError != null) return requiredError;
    if (value!.length < 6) {
      return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredError = requiredField(value, fieldName: 'تأكيد كلمة المرور');
    if (requiredError != null) return requiredError;
    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }
}
