import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_text_styles.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/views/owner_orders_view.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/views/owner_payments_view.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/widgets/owner_drawer.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/owner_section.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/views/owner_services_view.dart';
import 'package:digital_product/features/dashboard_owner/settings/presentation/views/owner_settings_view.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/views/owner_team_view.dart';
import 'package:flutter/material.dart';

class OwnerRootView extends StatefulWidget {
  const OwnerRootView({super.key});

  @override
  State<OwnerRootView> createState() => _OwnerRootViewState();
}

class _OwnerRootViewState extends State<OwnerRootView> {
  OwnerSection selectedSection = OwnerSection.orders;

  void _selectSection(OwnerSection section) {
    setState(() {
      selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      drawer: OwnerDrawer(
        selectedSection: selectedSection,
        onSectionSelected: _selectSection,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        title: const Text('لوحة التحكم', style: AppTextStyles.appTitle),
      ),
      body: IndexedStack(
        index: selectedSection.index,
        children: const [
          OwnerOrdersView(),
          OwnerServicesView(),
          OwnerTeamView(),
          OwnerPaymentsView(),
          OwnerSettingsView(),
        ],
      ),
    );
  }
}
