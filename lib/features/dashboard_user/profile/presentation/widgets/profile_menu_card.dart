import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({required this.onItemPressed, super.key});

  final ValueChanged<String> onItemPressed;

  static const List<({String title, IconData icon})> _items = [
    (title: 'إعدادات الإشعارات', icon: Icons.notifications_none_rounded),
    (title: 'الأمان وكلمة المرور', icon: Icons.lock_outline_rounded),
    (title: 'تواصل مع الدعم', icon: Icons.support_agent_rounded),
    (title: 'قيّم التطبيق', icon: Icons.star_border_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          for (int index = 0; index < _items.length; index++)
            ProfileMenuItem(
              title: _items[index].title,
              icon: _items[index].icon,
              showDivider: index != _items.length - 1,
              onTap: () => onItemPressed(_items[index].title),
            ),
        ],
      ),
    );
  }
}
