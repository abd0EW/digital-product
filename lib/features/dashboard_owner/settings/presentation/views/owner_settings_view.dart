import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/settings/presentation/widgets/owner_notifications_settings_section.dart';
import 'package:digital_product/features/dashboard_owner/settings/presentation/widgets/owner_platform_settings_section.dart';
import 'package:flutter/material.dart';

class OwnerSettingsView extends StatefulWidget {
  const OwnerSettingsView({super.key});

  @override
  State<OwnerSettingsView> createState() => _OwnerSettingsViewState();
}

class _OwnerSettingsViewState extends State<OwnerSettingsView> {
  final TextEditingController platformNameController = TextEditingController(
    text: 'منصة الخدمات',
  );
  final TextEditingController vatController = TextEditingController(text: '15');

  bool notifyOnNewOrder = true;
  bool notifyOnPayment = true;

  @override
  void dispose() {
    platformNameController.dispose();
    vatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: AppText.title('الإعدادات', textAlign: TextAlign.right),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  OwnerPlatformSettingsSection(
                    platformNameController: platformNameController,
                    vatController: vatController,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  OwnerNotificationsSettingsSection(
                    notifyOnNewOrder: notifyOnNewOrder,
                    notifyOnPayment: notifyOnPayment,
                    onNewOrderChanged: (value) {
                      setState(() {
                        notifyOnNewOrder = value;
                      });
                    },
                    onPaymentChanged: (value) {
                      setState(() {
                        notifyOnPayment = value;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: AppBottomSheetBtn(
        title: "حفظ الاعدادات",
        color: AppColors.primaryButtonBackground,
      ),
    );
  }
}
