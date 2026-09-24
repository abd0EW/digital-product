import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OwnerOrderTableHeader extends StatelessWidget {
  const OwnerOrderTableHeader({this.showAssignmentAction = false, super.key});

  final bool showAssignmentAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      spacing: 10,
      children: [
        Expanded(
          flex: 2,
          child: AppText.title(
            'العميل',
            textAlign: TextAlign.right,
            color: AppColors.headingText,
          ),
        ),
        Expanded(
          flex: 2,
          child: AppText.title(
            'الخدمة',
            textAlign: TextAlign.right,
            color: AppColors.headingText,
          ),
        ),
        Expanded(
          child: AppText.title(
            'المبلغ',
            textAlign: TextAlign.center,
            color: AppColors.headingText,
          ),
        ),
        Expanded(
          child: AppText.title(
            'الحالة',
            textAlign: TextAlign.center,
            color: AppColors.headingText,
          ),
        ),
        if (showAssignmentAction)
          Expanded(
            child: AppText.title(
              'إجراء',
              textAlign: TextAlign.center,
              color: AppColors.headingText,
            ),
          ),
      ],
    );
  }
}
