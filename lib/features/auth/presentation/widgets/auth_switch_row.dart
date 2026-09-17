import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AuthSwitchRow extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onPressed;

  const AuthSwitchRow({
    super.key,
    required this.text,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          AppText.body('$text ', color: AppColors.bodyText),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: AppText.title(actionText, color: AppColors.tealPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
