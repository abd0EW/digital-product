import 'package:digital_product/features/dashboard_owner/settings/presentation/widgets/owner_setting_switch_tile.dart';
import 'package:digital_product/features/dashboard_owner/settings/presentation/widgets/owner_settings_section.dart';
import 'package:flutter/material.dart';

class OwnerNotificationsSettingsSection extends StatelessWidget {
  const OwnerNotificationsSettingsSection({
    required this.notifyOnNewOrder,
    required this.notifyOnPayment,
    required this.onNewOrderChanged,
    required this.onPaymentChanged,
    super.key,
  });

  final bool notifyOnNewOrder;
  final bool notifyOnPayment;
  final ValueChanged<bool> onNewOrderChanged;
  final ValueChanged<bool> onPaymentChanged;

  @override
  Widget build(BuildContext context) {
    return OwnerSettingsSection(
      title: 'الإشعارات',
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            OwnerSettingSwitchTile(
              title: 'إشعار عند وصول طلب جديد',
              value: notifyOnNewOrder,
              onChanged: onNewOrderChanged,
            ),
            OwnerSettingSwitchTile(
              title: 'إشعار عند استلام دفعة',
              value: notifyOnPayment,
              onChanged: onPaymentChanged,
            ),
          ],
        ),
      ),
    );
  }
}
