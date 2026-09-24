import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/owner_section.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/widgets/owner_drawer_header.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/widgets/owner_drawer_item.dart';
import 'package:flutter/material.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({
    required this.selectedSection,
    required this.onSectionSelected,
    super.key,
  });

  final OwnerSection selectedSection;
  final ValueChanged<OwnerSection> onSectionSelected;

  void _selectSection(BuildContext context, OwnerSection section) {
    onSectionSelected(section);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.navyPrimary,
      child: SafeArea(
        child: Column(
          children: [
            const OwnerDrawerHeader(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                children: [
                  OwnerDrawerItem(
                    title: 'الطلبات',
                    icon: Icons.receipt_long_rounded,
                    isSelected: selectedSection == OwnerSection.orders,
                    onTap: () => _selectSection(context, OwnerSection.orders),
                  ),
                  OwnerDrawerItem(
                    title: 'الخدمات',
                    icon: Icons.grid_view_rounded,
                    isSelected: selectedSection == OwnerSection.services,
                    onTap: () => _selectSection(context, OwnerSection.services),
                  ),
                  OwnerDrawerItem(
                    title: 'الفريق',
                    icon: Icons.groups_rounded,
                    isSelected: selectedSection == OwnerSection.team,
                    onTap: () => _selectSection(context, OwnerSection.team),
                  ),
                  OwnerDrawerItem(
                    title: 'المدفوعات',
                    icon: Icons.payments_rounded,
                    isSelected: selectedSection == OwnerSection.payments,
                    onTap: () => _selectSection(context, OwnerSection.payments),
                  ),
                  OwnerDrawerItem(
                    title: 'الإعدادات',
                    icon: Icons.settings_rounded,
                    isSelected: selectedSection == OwnerSection.settings,
                    onTap: () => _selectSection(context, OwnerSection.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
