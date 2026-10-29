import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/widgets/acount_type_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountTypeSelector extends StatelessWidget {
  const AccountTypeSelector({
    super.key,
    required this.valueListenable,
    required this.onChanged,
  });

  final ValueListenable<UserRole> valueListenable;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserRole>(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return Row(
          spacing: AppSpacing.xs,
          children: [
            Expanded(
              child: AccountTypeItem(
                title: 'عميل',
                icon: Icons.person,
                isSelected: value == UserRole.user,
                onTap: () {
                  onChanged(UserRole.user);
                },
              ),
            ),

            Expanded(
              child: AccountTypeItem(
                title: 'مزود خدمة',
                icon: Icons.business_outlined,
                isSelected: value == UserRole.owner,
                onTap: () {
                  onChanged(UserRole.owner);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
