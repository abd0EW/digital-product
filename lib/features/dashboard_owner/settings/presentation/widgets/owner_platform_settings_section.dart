import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:digital_product/features/dashboard_owner/settings/presentation/widgets/owner_settings_section.dart';
import 'package:flutter/material.dart';

class OwnerPlatformSettingsSection extends StatelessWidget {
  const OwnerPlatformSettingsSection({
    required this.platformNameController,
    required this.vatController,
    super.key,
  });

  final TextEditingController platformNameController;
  final TextEditingController vatController;

  @override
  Widget build(BuildContext context) {
    return OwnerSettingsSection(
      title: 'إعدادات المنصة',
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.title('اسم المنصة', textAlign: TextAlign.right),
            const SizedBox(height: AppSpacing.xs),
            AppTextField(
              controller: platformNameController,
              hintText: 'منصة الخدمات',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSpacing.md),
            AppText.title(
              'نسبة ضريبة القيمة المضافة (%)',
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: AppSpacing.xs),
            AppTextField(
              controller: vatController,
              keyboardType: TextInputType.number,
              hintText: '15',
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }
}
