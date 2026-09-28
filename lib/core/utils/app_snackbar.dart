import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(_getIcon(type), color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: _getColor(type),
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  static void success(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackbarType.success);
  }

  static void error(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackbarType.error);
  }

  static void warning(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackbarType.warning);
  }

  static void info(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackbarType.info);
  }

  static Color _getColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return AppColors.success;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.warning:
        return AppColors.warning;
      case SnackbarType.info:
        return AppColors.primaryButtonBackground;
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_outline;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.warning:
        return Icons.warning_amber_rounded;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }
}
